class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :orders
  has_many :payments
  has_many :addresses, -> { where(address_type: Address::AddressType::User).order('id desc') }
  # belongs_to :default_address, class_name: :Address
  belongs_to :default_address, class_name: :Address, optional: true

  attr_accessor :password, :password_confirmation, :token

  CELLPHONE_RE = /\A(\+86|86)?1\d{10}\z/
  EMAIL_RE = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

  validate :validate_email_or_cellphone, on: :create

  # validates_presence_of :email, message: '邮箱不能为空'
  # validates_format_of :email, message: '邮箱格式不正确',
  #                     with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
  #                     if: proc { |user| !user.email.blank? }
  # validates :email, uniqueness: true

  validates_presence_of :password, message: '密码不能为空', if: :need_validate_password
  validates_presence_of :password_confirmation, message: '确认密码不能为空', if: :need_validate_password
  validates_confirmation_of :password, message: '两次密码输入不一致', if: :need_validate_password
  validates_length_of :password, message: '密码最短为6位', minimum: 6, if: :need_validate_password

  def username
    self.cellphone || (self.email and self.email.split('@').first)
  end

  private

  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end

  def validate_email_or_cellphone
    if [self.email, self.cellphone].all? { |attr| attr.nil? }
      self.errors.add :base, "邮箱和手机号其中之一不能为空"
      return false
    else
      if self.cellphone.nil? # 如果手机号是空，填写的是 email
        if self.email.blank?
          self.errors.add :email, "邮箱不能为空"
          return false
        else
          unless self.email =~ EMAIL_RE
            self.errors.add :email, "邮箱格式不正确"
            return false
          end
        end
      else
        unless self.cellphone =~ CELLPHONE_RE
          self.errors.add :cellphone, "手机号格式不正确"
          return false
        end

        unless VerifyToken.available.find_by(cellphone: self.cellphone, token: self.token)
          self.errors.add :cellphone, "手机验证码不正确或者已过期"
          return false
        end
      end
    end

    return true
  end
end

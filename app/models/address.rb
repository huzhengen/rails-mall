class Address < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :address_type
  validates_presence_of :address, message: '地址不能为空'
  validates_presence_of :cellphone, message: '手机不能为空'
  validates_presence_of :contact_name, message: '姓名不能为空'
  validates_presence_of :zipcode, message: '邮编不能为空'

  attr_accessor :set_as_default

  after_save :set_as_default_address
  before_destroy :remove_self_as_default_address

  module AddressType
    User = 'user'
    Order = 'order'
  end

  def set_as_default_address
    # 如果设置默认地址
    if self.set_as_default.to_i == 1
      self.user.default_address = self
      self.user.save!
    else
      remove_self_as_default_address
    end
  end

  # 删除掉一个地址的时候，如果该地址是默认地址，需要在 user 里移除该地址
  def remove_self_as_default_address
    if self.user.default_address == self
      self.user.default_address = nil
      self.user.save!
    end
  end

end

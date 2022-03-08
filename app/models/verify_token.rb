class VerifyToken < ApplicationRecord

  validates_presence_of :token, message: '验证码不能为空'
  validates_presence_of :cellphone, message: '手机号不能为空'

  scope :available, -> { where('expired_at > :time', time: Time.now) }

  def self.upsert cellphone, token
    cond = {
      cellphone: cellphone
    }
    record = self.find_by(cond)
    if record
      record.update_attributes(token: token, expired_at: Time.now + 10.minutes)
    else
      record = self.create cond.merge(token: token, expired_at: Time.now + 10.minutes)
    end

    record
  end

end

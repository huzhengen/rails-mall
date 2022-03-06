class Payment < ApplicationRecord
  before_create :gen_payment_no

  belongs_to :user
  has_many :orders

  validates_presence_of :user_id, message: '用户不能为空'
  validates_presence_of :total_money, message: '总价不能为空'
  validates_presence_of :status, message: '状态不能为空'

  module PaymentStatus
    Initial = 'initial'
    Failed = 'failed'
    Success = 'success'
  end

  def self.create_from_orders! user, *orders
    orders = orders.flatten!

    payment = nil
    transaction do
      payment = user.payments.create!(
        total_money: orders.sum(&:total_money)
      )
      orders.each do |order|
        raise "order #{order.order_no} has already paid!" if order.is_paid?

        order.payment = payment
        order.save!
      end
    end
    payment

  end

  private

  def gen_payment_no
    self.payment_no = RandomCode.generate_utoken(32)
  end

end

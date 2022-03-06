class Order < ApplicationRecord
  validates_presence_of :user_id, message: '用户不能为空'
  validates_presence_of :product_id, message: '商品不能为空'
  validates_presence_of :address_id, message: '地址不能为空'
  validates_presence_of :total_money, message: '总价不能为空'
  validates_presence_of :amount, message: '数量不能为空'
  validates :order_no, uniqueness: true

  belongs_to :user
  belongs_to :product
  belongs_to :address
  belongs_to :payment, optional: true

  before_create :generate_order_no

  module OrderStatus
    Initial = 'initial'
    Paid = 'paid'
  end

  def is_paid?
    self.status == OrderStatus::Paid
  end

  def self.create_order_from_shopping_carts! user, address, *shopping_carts
    shopping_carts.flatten!
    address_attrs = address.attributes.except!("id", "created_at", "updated_at")

    orders = []
    transaction do
      order_address = user.addresses.create!(address_attrs.merge(
        "address_type" => Address::AddressType::Order
      ))

      shopping_carts.each do |shopping_cart|
        orders << user.orders.create!(
          product: shopping_cart.product,
          address: order_address,
          amount: shopping_cart.amount,
          total_money: shopping_cart.amount * shopping_cart.product.price
        )
      end

      shopping_carts.map(&:destroy!)
    end

    orders

  end

  private

  def generate_order_no
    self.order_no = RandomCode.generate_order_uuid
  end

end

class PaymentsController < ApplicationController
  before_action :auth_user

  def index

  end

  def generate_pay
    orders = current_user.orders.where(order_no: params[:order_nos].split(','))
    payment = Payment.create_from_orders!(current_user, orders)
    redirect_to payments_path(payment_no: payment.payment_no)
  end
end
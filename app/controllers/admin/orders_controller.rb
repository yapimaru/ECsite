class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :payment_method, :postal_code, :status, :address, :shipping_cost, :total_payment)
  end
end

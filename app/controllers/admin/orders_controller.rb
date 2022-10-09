class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.order_details.update_all(making_status: "wait") if @order.status == "confirm"
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :payment_method, :postal_code, :status, :address, :shipping_cost, :total_payment)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :making_status, :amount, :create_at)
  end
end

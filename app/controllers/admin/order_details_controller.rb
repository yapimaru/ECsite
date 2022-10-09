class Admin::OrderDetailsController < ApplicationController
  def index
    @orders = Order.all
  end

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:order_detail][:order_id])
    if @order_detail.update(order_detail_params)
      @order.update(status: "making") if @order_detail.making_status == "making"
    end
    if @order.order_details.count == @order.order_details.where(making_status: "complete").count
       @order.status = "preparation"
       @order.save
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :making_status, :amount, :create_at)
  end
end

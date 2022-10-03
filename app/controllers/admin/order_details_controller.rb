class Admin::OrderDetailsController < ApplicationController
  def index
    @orders = Order.all
  end
  
  

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :making_status, :amount, :create_at)
  end
end

class Public::OrderDetailsController < ApplicationController
  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :making_status, :amount)
  end
end

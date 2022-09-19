class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.all
    @total = 0
  end

  def create
    if @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_item = CartItem.all
      @total = 0
      render :index
    end
  end

  def destroy
    current_customer.cart_items.destroy_all
    redirect_to root_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end

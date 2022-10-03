class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = Address.all
  end

  def confirmation
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @cart_items = current_customer.cart_items.all
    @total = 0
    if params[:order][:address_option] == 0
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == 1
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] == 2
      @address = Address.new(address_params)
      @address.customer_id = current_customer.id
      @address.save
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def confirm
    @order = Order.new(order_params)
    @order.save
    @cart_items =current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new(order_detail_params)
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item_id
      @order_details.price = cart_item.item.price
      @order_details.amount = cart_item.amount
      @order_details.save
    end
    current_user.cart_items.destroy_all
    render :complete
  end

  def complete
  end
  
  def index
    @order_details = OrderDetail.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :payment_method, :postal_code, :status, :address, :shipping_cost, :total_payment)
  end

  def address_params
    params.require(:address).permit(:postal_code, :name, :address, :customer_id)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :making_status, :amount, :create_at)
  end
end

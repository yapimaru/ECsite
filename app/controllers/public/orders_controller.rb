class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.all
    @address = @addresses.current_customer.id
  end

  def confirmation
    @cart_items = CartItem.all
    @total = 0
    if address_option == 0
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif address_option == 1
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif address_option == 2
      @order = Order.new(order_params)
      @order.save
    end
  end
  
  def complete
    
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :payment_method, :postal_code, :status, :address, :shipping_cost, :total_payment)
  end
end

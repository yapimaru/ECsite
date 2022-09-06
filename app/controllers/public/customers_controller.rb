class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    #@last_name = Customer.find_by(last_name: params[:customer][:last_name])
    #@first_name = Customer.find_by(first_name: params[:customer][:first_name])
    #@last_name_kana = Customer.find_by(last_name_kana: params[:customer][:last_name_kana])
    #@first_name_kana = Customer.find_by(first_name_kana: params[:customer][:first_name_kana])
    #@email = Customer.find_by(email: params[:customer][:email])
    #@postal_code = Customer.find_by(postal_code: params[:customer][:postal_code])
    #@address = Customer.find_by(address: params[:customer][:address])
    #@phone_number = Customer.find_by(phone_number: params[:customer][:phone_number])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render :edit
    end
  end

  def confirmation

  end

  def withdraw
    @customer = current_customer
    @customer.update(is_delete: true)
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number)
  end

end

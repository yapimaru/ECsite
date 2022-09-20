class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end
  
  def create
    @Address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @address = Address.new
      render :index
    end
  end
  
  
end

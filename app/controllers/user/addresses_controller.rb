class User::AddressesController < ApplicationController


  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def edit
    @addresses = Address.find(params[:id])
  end

  def create
    @addresses = Address.new(address_params)
    @addresses.customer_id = current_customer.id
    @addresses.save
    redirect_to addresses_path
  end

  def update
    @addresses = Address.find(params[:id])
    @addresses.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @addresses = Address.find(params[:id])
    @addresses.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :address, :post_code)
  end

end
class AddressesController < ApplicationController
  layout false
  before_action :auth_user
  before_action :find_address, only: %i[edit update destroy set_default_address]

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      @addresses = current_user.reload.addresses
      render json: {
        status: 'ok',
        data: render_to_string(file: 'addresses/index')
      }
    else
      render json: {
        status: 'error',
        data: render_to_string(file: 'addresses/new')
      }
    end
  end

  def edit
    render action: new
  end

  def update
    if @address.update(address_params)
      @addresses = current_user.reload.addresses
      render json: {
        status: 'ok',
        data: render_to_string(file: 'addresses/index')
      }
    else
      render json: {
        status: 'error',
        data: render_to_string(file: 'addresses/new')
      }
    end
  end

  def destroy
    if @address.destroy
      @addresses = current_user.reload.addresses
      render json: {
        status: 'ok',
        data: render_to_string(file: 'addresses/index')
      }
    end
  end

  def set_default_address
    @address.set_as_default = 1 # 在 address model 里已经写好了，address 保存的时候，配置默认地址
    if @address.save
      @addresses = current_user.reload.addresses
      render json: {
        status: 'ok',
        data: render_to_string(file: 'addresses/index')
      }
    end
  end

  private

  def find_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:contact_name, :cellphone, :zipcode, :address, :set_as_default)
  end
end
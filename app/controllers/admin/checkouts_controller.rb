class Admin::CheckoutsController < ApplicationController
  before_action :basic_auth
  before_action :set_order, only: %i[show]

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
    @OrderDetail = @order.OrderDetail
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to root_path, notice: "購入ありがとうございます", status: :see_other
    else
      render carts_path, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to root_path, notice: "delete order.", status: :see_other
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  
  def order_params
    params.require(:order).permit(
      :firstname,
      :lastname,
      :username,
      :email,
      :address1,
      :address2,
      :country,
      :zip,
      :ccname,
      :ccnumber,
      :ccexpiration,
      :cccvv
    )
  end
end

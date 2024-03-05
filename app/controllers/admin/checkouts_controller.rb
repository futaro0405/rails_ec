class Admin::CheckoutsController < ApplicationController
  include CurrentCart
  before_action :set_current_cart
  before_action :basic_auth, only: %i[index show]
  before_action :set_order, only: %i[show]

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
    @OrderDetail = @order.order_details
  end

  def create
    @order = Order.new(order_params)
    @cart_items = CartItem.joins(:item).where(cart_id: session[:cart_id]).select('items.name, items.price, cart_items.quantity')

    @cart_items.each do |n|
      @OrderDetail = @order.order_details.build(
        name: n.name,
        quantity: n.quantity,
        price: n.price
      )
      @OrderDetail.save
    end

    OrderMailer.complete(@order, @OrderDetail).deliver_later

    @cart = Cart.find_by(id: session[:cart_id])
    @cart.destroy

    if @order.save
      redirect_to root_path, notice: "購入ありがとうございます", status: :see_other
    else
      flash.now[:notice] = "失敗"
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

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def set_current_cart
    @current_cart = current_cart
    session[:cart_id] ||= @current_cart.id
  end
end

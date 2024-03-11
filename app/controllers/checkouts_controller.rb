# frozen_string_literal: true

class CheckoutsController < ApplicationController
  include CurrentCart
  before_action :set_current_cart

  def create
    @order = Order.new(order_params)

    set_order_details

    OrderMailer.complete(@order).deliver_later

    @cart = Cart.find_by(id: session[:cart_id])
    @cart.destroy

    if @order.save
      redirect_to root_path, notice: '購入ありがとうございます', status: :see_other
    else
      flash.now[:notice] = '失敗'
      render carts_path, status: :unprocessable_entity
    end
  end

  private

  def set_order_details
    @cart_items = CartItem.joins(:item).where(
      cart_id: session[:cart_id]
    ).select(
      'items.name, items.price, cart_items.quantity'
    )

    @cart_items.each do |n|
      @order_detail = @order.order_details.build(
        name: n.name,
        quantity: n.quantity,
        price: n.price
      )
      @order_detail.save
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

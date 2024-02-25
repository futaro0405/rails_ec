# frozen_string_literal: true

class CartsController < ApplicationController
  include CurrentCart
  before_action :set_current_cart
  before_action :set_cart_item, only: %i[create update]

  def index
    @cart_items = CartItem.joins(:item).where(cart_id: session[:cart_id]).select('cart_items.*, items.*')
    @count = @current_cart.cart_items.count
    @total = @current_cart.cart_items.inject(0) { |sum, item| sum + item.sum_price }
    @order = Order.new
  end

  def create
    @cart_item ||= @current_cart.cart_items.build(item_id: params[:item_id])
    @cart_item.quantity += params[:quantity].to_i
    if @cart_item.save
      redirect_to carts_url,
                  notice: "Add product to cart. name: #{@cart_item.item.name} quantity: #{@cart_item.quantity}"
    else
      redirect_to carts_url, notice: 'Deletion failed. Please try agein.'
    end
  end

  def update
    if @cart_item
      @cart_item.increment(:quantity, params[:quantity].to_i)
      redirect_to carts_url,
                  notice: "Add product to cart. name: #{@cart_item.item.name} quantity: #{@cart_item.quantity}"
    else
      create
    end
  end

  def destroy
    @cart_item = @current_cart.cart_items.find_by(item_id: params[:id])
    if @cart_item.destroy
      redirect_to carts_url, notice: "Delete the item in cart. name: #{@cart_item.id}", status: :see_other
    else
      render carts_url, alert: 'Deletion failed. Please try agein.'
    end
  end

  private

  def set_current_cart
    @current_cart = current_cart
    session[:cart_id] ||= @current_cart.id
  end

  def set_cart_item
    @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
  end

  def cart_params
    params.require(:cart_item).permit(:quantity)
  end
end

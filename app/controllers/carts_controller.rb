class CartsController < ApplicationController
  before_action :set_cart_item, only: %i[add_item update_item destroy]

  # カート内アイテムの表示
  def index
    @cart_items = current_cart.cart_items.includes([:item])
    @count = @cart_items.count
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end

  def add_item
    @cart_item ||= current_cart.cart_items.build(item_id: params[:item_id])
    @cart_item.quantity += params[:quantity].to_i
    if @cart_item.save
      redirect_to carts_url, notice: "Add product to cart. name: #{@cart_item.name} quantity: #{@cart_item.quantity}", status: :see_other
    else
      render carts_url, alert: "Deletion failed. Please try agein."
    end
  end

  def destroy
    if @cart_item.destroy
      redirect_to carts_url, notice: "Delete the item in cart. name: #{@cart_item.name}", status: :see_other
    else
      render carts_url, alert: "Deletion failed. Please try agein."
    end
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
  end
end
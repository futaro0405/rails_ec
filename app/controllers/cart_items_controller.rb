# frozen_string_literal: true

class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_current_cart

  def destroy
    @cart_item = @current_cart.cart_items.find_by(item_id: params[:id])
    if @cart_item.destroy
      redirect_to carts_url, notice: "Delete the item in cart. name: #{@cart_item.id}", status: :see_other
    else
      render carts_url, alert: 'Deletion failed. Please try agein.'
    end
  end
end

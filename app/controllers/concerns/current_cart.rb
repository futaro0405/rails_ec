# frozen_string_literal: true

module CurrentCart
  extend ActiveSupport::Concern

  def current_cart
    Cart.find_or_create_by(id: session[:cart_id])
  end

  def set_current_cart
    @current_cart = current_cart
    session[:cart_id] ||= @current_cart.id
  end
end

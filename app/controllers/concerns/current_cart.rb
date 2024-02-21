# frozen_string_literal: true

module CurrentCart
  extend ActiveSupport::Concern

  def current_cart
    current_cart = Cart.find_by(id: session[:cart_id])
    current_cart ||= Cart.create
    session[:cart_id] ||= current_cart.id
    current_cart
  end
end

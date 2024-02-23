# frozen_string_literal: true

module CurrentCart
  extend ActiveSupport::Concern

  def current_cart
    current_cart = Cart.find_or_create_by(id: session[:cart_id])
  end
end

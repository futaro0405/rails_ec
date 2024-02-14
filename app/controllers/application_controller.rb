# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_cart

  def current_cart
    current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= current_cart.id
  end
end

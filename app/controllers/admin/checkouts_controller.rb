# frozen_string_literal: true

module Admin
  class CheckoutsController < ApplicationController
    include CurrentCart
    before_action :set_current_cart
    before_action :basic_auth, only: %i[index show]
    before_action :set_order, only: %i[show]

    def index
      @orders = Order.all.order(created_at: :desc)
    end

    def show
      @order_detail = @order.order_details
    end

    def destroy
      @order.destroy
      redirect_to root_path, notice: 'delete order.', status: :see_other
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
  end
end

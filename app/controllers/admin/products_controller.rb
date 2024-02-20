# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth
    before_action :set_item, only: %i[show edit update destroy]
    protect_from_forgery with: :exception

    def index
      @items = Item.all
    end

    def show; end

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)

      if @item.save
        redirect_to admin_product_url(@item), notice: "created new item. name: #{@item.name}", status: :see_other
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @item.update(item_params)
        redirect_to admin_products_url, notice: "updated item. name: #{@item.name}", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @item.destroy
      redirect_to admin_products_url, notice: "delete item. name: #{@item.name}", status: :see_other
    end

    private

    def item_params
      params.require(:item).permit(:no, :name, :price, :description, :image)
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end
end

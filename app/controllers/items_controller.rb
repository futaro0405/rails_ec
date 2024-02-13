# frozen_string_literal: true

class ItemsController < ApplicationController
  add_flash_types :success, :info, :warning, :danger

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @related_items = Item.all.order(created_at: :desc).first(4)
  end

  private

  def item_params
    params.require(:item).permit(:no, :name, :price, :description, :image)
  end
end

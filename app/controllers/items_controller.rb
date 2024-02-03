# frozen_string_literal: true

class ItemsController < ApplicationController
  add_flash_types :success, :info, :warning, :danger

  def index
    @items = Item.all
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save!
    redirect_to item_url, notice: '#created new item. name: {item.name}'
  end

  def edit; end

  private

  def item_params
    params.require(:item).permit(:id, :name, :price, :description, :image)
  end
end

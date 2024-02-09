# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  add_flash_types :success, :info, :warning, :danger

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
    @related_items = Item.all.order(created_at: :desc).first(4)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash.notice = "created new item. name: #{@item.name}"
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @item.update!(item_params)
    redirect_to items_url, notice: "updated item. name: #{@item.name}", status: :see_other
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "delete item. name: #{@item.name}", status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:no, :name, :price, :description, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

class PromotionsController < ApplicationController

  def create
    @promotion = Promotion.find_by(code: params[:code])
    session[:code] = @promotion.code
  end

  def update

  end

  def destroy

  end

  private
end

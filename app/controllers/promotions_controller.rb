# frozen_string_literal: true

class PromotionsController < ApplicationController
  def create
    @promotion = Promotion.find_by(code: params[:code])

    if @promotion.present?
      session[:code] = @promotion.code
      redirect_to carts_url,
                  notice: "Promotion code applied. code: #{session[:code]}"
    else
      redirect_to carts_url, notice: 'promotion code not found.'
    end
  end
end

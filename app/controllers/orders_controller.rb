class OrdersController < ApplicationController

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to root_path, notice: "購入ありがとうございます", status: :see_other
    else
      render carts_path, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to root_path, notice: "delete order.", status: :see_other
  end

  private

  def order_params
    params.require(:order).permit(
      :firstname,
      :lastname,
      :username,
      :email,
      :address1,
      :address2,
      :country,
      :zip,
      :ccname,
      :ccnumber,
      :ccexpiration,
      :cccvv
    )
  end
end

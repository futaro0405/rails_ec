class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  def sum_price
    item.price * quantity
  end
end

class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  def sum
    item.price * quantity
  end
end

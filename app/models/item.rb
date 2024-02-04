# frozen_string_literal: true

class Item < ApplicationRecord
  has_one_attached :image

  def thumnail
    image.variant(resize_to_limit: [300, 300])
  end
end

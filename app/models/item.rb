# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :cart_item
  before_validation :set_nameless_name
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  has_one_attached :image

  def thumnail
    image.variant(resize_to_limit: [300, 300])
  end

  private

  def set_nameless_name
    self.name = 'no name' if name.blank?
  end

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end

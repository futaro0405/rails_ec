# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do |n|
  Item.find_or_create_by!(no: "BTS-00#{n}") do |item|
    item.name = "item-0#{n}"
    item.price = 12_000
    item.description = 'dummytext dummytext dummytext dummytext'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dummy.jpg"), filename:"dummy.jpg")
  end
end

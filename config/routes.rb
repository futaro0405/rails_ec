# frozen_string_literal: true

Rails.application.routes.draw do
  get '/my_cart' => 'carts#my_cart'
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'

  namespace :admin do
    resources :products
  end

  resources :items
  root to: 'items#index'
end

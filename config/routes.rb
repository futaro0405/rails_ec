# frozen_string_literal: true

Rails.application.routes.draw do
  resources :carts
  post '/add_item' => 'carts#add_item'
  delete '/delete_item' => 'carts#delete_item'

  namespace :admin do
    resources :products
  end

  resources :items
  root to: 'items#index'
end

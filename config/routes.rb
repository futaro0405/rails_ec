# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items, only: %i[index show]
  resources :carts, only: %i[index create update destroy]
  resources :cart_items, only: %i[destroy]
  resources :checkouts, only: %i[create]

  namespace :admin do
    resources :products
    resources :checkouts
  end

  root to: 'items#index'
end

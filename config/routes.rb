# frozen_string_literal: true

Rails.application.routes.draw do
  resources :inquiries
  resources :items, only: %i[index show]
  resources :carts, only: %i[index create update destroy]
  resources :cart_items, only: %i[destroy]

  namespace :admin do
    resources :products
    resources :checkouts
  end

  root to: 'items#index'
end

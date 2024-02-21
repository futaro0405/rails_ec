# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items, only: %i[index show]
  resources :carts, only: %i[index create update destroy]
  resources :orders

  namespace :admin do
    resources :products
  end

  root to: 'items#index'
end

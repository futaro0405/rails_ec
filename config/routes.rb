# frozen_string_literal: true

Rails.application.routes.draw do
  resources :carts, only: %i[index create update destroy]

  namespace :admin do
    resources :products
  end

  resources :items, only: %i[index show]
  root to: 'items#index'
end

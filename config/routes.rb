# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'orders#index'

  resources :orders
  resources :packages
  resources :users
  resources :qr_codes, only: %i[index]
  post '/scan', to: 'qr_codes#scan'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboards#index'

  resources :orders
  resources :packages
  resources :qr_codes, only: %i[index]
  post '/scan', to: 'qr_codes#scan'
end

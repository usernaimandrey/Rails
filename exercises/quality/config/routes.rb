# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  # BEGIN
  get '/bulletins/', to: 'bulletins#index'

  resources :bulletins, only: :show
  # END
end

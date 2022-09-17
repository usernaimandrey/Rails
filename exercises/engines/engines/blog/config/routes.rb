# frozen_string_literal: true

Blog::Engine.routes.draw do
  root 'posts#index'

  resources :posts
end

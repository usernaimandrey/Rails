# frozen_string_literal: true

Rails.application.routes.draw do
  resources :vacancies do
    # BEGIN
    member do
      patch :publish
      patch :archive
    end
    # END
  end

  root 'vacancies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

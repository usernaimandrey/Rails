# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  get '/:locale', to: 'home#index', as: :root, defaults: { locale: :en }
  get '/', to: redirect('/%{locale}'), defaults: { locale: :en }

  scope ('/:locale'), locale: /en|ru/  do
    resources :posts do
      scope module: :posts do
        resources :comments, only: %i[create destroy edit update]
      end
    end
  end
  # END
end

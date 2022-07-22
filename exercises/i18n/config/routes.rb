# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  get '/', to: redirect('/%{locale}'), defaults: { locale: I18n.default_locale }

  scope ('/:locale'), locale: /en|ru/  do
    root 'home#index', defaults: { locale: I18n.default_locale }

    resources :posts do
      scope module: :posts do
        resources :comments, only: %i[create destroy edit update]
      end
    end
  end
  # END
end

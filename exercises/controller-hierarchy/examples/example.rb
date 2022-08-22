# frozen_string_literal: true

# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
  end

  scope module: :web do
    namespace :admin do
    end

    root 'home#index'

    shallow do
      resources :books, only: index do
        resources :comments, except: %i[edit update]
      end

      resources :users do
        resources :books
        resources :comments, only: [:index]
      end
    end
  end
end

# app/controllers/web/application_controller.rb
# Иерархия контроллеров позволяет разделять контекст и удобно создавать вложенные модули
module Web
  class ApplicationController < ActionController::Base
  end
end

# app/controllers/web/books/application_controller.rb
# Каждый модуль содержит свой ApplicationController
module Web
  module Books
    class ApplicationController < Web::ApplicationController
      helper_method :resource_book

      def resource_book
        @resource_book ||= Book.find params[:book_id]
      end
    end
  end
end

# app/controllers/web/books/comments_controller.rb
module Web
  module Books
    class CommentsController < Web::Books::ApplicationController
      def index
        @comments = resource_book.comments.order(id: :desc)
      end
    end
  end
end

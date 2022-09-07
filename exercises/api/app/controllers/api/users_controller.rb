# frozen_string_literal: true

module Api
  class UsersController < Api::ApplicationController
    # BEGIN
    def index
      users = User.all

      respond_with users.as_json(only: %i[first_name last_name email addres state])
    end

    def show
      user = User.find(params[:id])

      respond_with user.as_json(only: %i[first_name last_name email addres state])
    end
    # END
  end
end

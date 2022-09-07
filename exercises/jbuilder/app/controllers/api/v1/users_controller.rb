# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::ApplicationController
      # BEGIN
      def index
        @users = user_limit(params[:limit])
        respond_to do |format|
          format.json
        end
      end

      def show
        @user = User.find(params[:id])
        respond_to do |format|
          format.json
        end
      end
      # END
    end
  end
end

# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    def new
      @user = User.new
    end

    def create
      @user = User.new(users_params)

      if @user.save
        redirect_to root_path, notice: t('.success')
      else
        flash.now[:alert] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    private

    def users_params
      params.require(:user).permit(:name)
    end
  end
end

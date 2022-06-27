# frozen_string_literal: true

class BulletinsController < ApplicationController
  # BEGIN
  def index
    @bulletins = Bulletin.where(published: true).order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find_by(id: params[:id])
  end
  # END
end

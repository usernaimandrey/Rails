# frozen_string_literal: true

class BulletinsController < ApplicationController
  # BEGIN
  def index
    @bulletins = Bulletin.where(published: true).order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id]).published ? Bulletin.find(params[:id]) : not_found
  end
  # END
end

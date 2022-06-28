# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.limit(15)
  end

  def show
    id = params[:id]
    @article = Article.find(id)
  end
end

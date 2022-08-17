# frozen_string_literal: true

class PostsController < ApplicationController
  # BEGIN
  after_action :verify_authorized

  def index
    @posts = authorize Post.all
  end

  def show
    @post = resource_post
  end

  def new
    @post = authorize Post.new
  end

  def create
    @post = current_user&.posts&.build(post_params)
    raise Pundit::NotAuthorizedError unless @post.present?

    authorize @post

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = resource_post
  end

  def update
    if resource_post.update(post_params)
      redirect_to resource_post, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if resource_post.destroy
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.faill')
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def resource_post
    @resource_post ||= authorize Post.find(params[:id])
  end
  # END
end

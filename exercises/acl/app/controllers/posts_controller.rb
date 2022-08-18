# frozen_string_literal: true

class PostsController < ApplicationController
  # BEGIN
  after_action :verify_authorized, only: %i[new create destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = resource_post
  end

  def new
    authorize Post
    @post = Post.new
  end

  def create
    authorize Post

    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = authorize resource_post
  end

  def update
    authorize resource_post

    if resource_post.update(post_params)
      redirect_to resource_post, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize resource_post

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
    @resource_post ||= Post.find(params[:id])
  end
  # END
end

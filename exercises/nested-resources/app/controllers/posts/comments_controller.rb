# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    def create
      @post = resource_post
      @comment = @post.comments.build(comment_params)

      if @comment.save
        redirect_to post_path(@post), notice: 'Comment was successfully created.'
      else
        flash[:alert] = 'Ooops! Something went wrong'
        render 'posts/show', status: :unprocessable_entity
      end
    end

    def edit
      @post = resource_post
      @comment = Post::Comment.find(params[:id])
    end

    def update
      @post = resource_post
      @comment = Post::Comment.find(params[:id])

      if @comment.update(comment_params)
        redirect_to post_path(@post), notice: 'Comment was successfully update.'
      else
        flash[:alert] = 'Ooops! Something went wrong'
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post = resource_post
      @comment = Post::Comment.find(params[:id])
      if @comment.destroy
        redirect_to post_path(@post), notice: 'Comment was successfully delete.'
      else
        flash[:alert] = 'Ooops! Something went wrong'
        render 'posts/show', status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:post_comment).permit(:body)
    end
  end
end

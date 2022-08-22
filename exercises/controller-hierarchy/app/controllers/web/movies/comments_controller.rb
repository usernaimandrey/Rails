# frozen_string_literal: true

module Web
  module Movies
    class CommentsController < Movies::ApplicationController
      def index
        @comments = resource_movie.comments.order(created_at: :desc)
      end

      def new
        @comment = resource_movie.comments.build
      end

      def create
        @comment = resource_movie.comments.build(comments_params)

        if @comment.save
          redirect_to movie_comments_path, notice: t('.success')
        else
          render :new
        end
      end

      def edit
        @comment = resource_movie.comments.find(params[:id])
      end

      def update
        @comment = resource_movie.comments.find(params[:id])

        if @comment.update(comments_params)
          redirect_to movie_comments_path, notice: t('.success')
        else
          render :edit
        end
      end

      def destroy
        @comment = resource_movie.comments.find(params[:id])

        if @comment.destroy
          flash[:notice] = t('.success')
        else
          flash[:aler] = t('.fail')
        end
        redirect_to movie_comments_path
      end

      private

      def comments_params
        params.require(:comment).permit(:body)
      end
    end
  end
end

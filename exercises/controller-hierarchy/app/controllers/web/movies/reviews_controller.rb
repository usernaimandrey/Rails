# frozen_string_literal: true

module Web
  module Movies
    class ReviewsController < Movies::ApplicationController
      def index
        @reviews = resource_movie.reviews.order(created_at: :desc)
      end

      def new
        @review = resource_movie.reviews.build
      end

      def create
        @review = resource_movie.reviews.build(review_params)

        if @review.save
          redirect_to movie_reviews_path, notice: t('.success')
        else
          render :new
        end
      end

      def edit
        @review = resource_movie.reviews.find(params[:id])
      end

      def update
        @review = resource_movie.reviews.find(params[:id])

        if @review.update(review_params)
          redirect_to movie_reviews_path, notice: t('.success')
        else
          render :edit
        end
      end

      def destroy
        @review = resource_movie.reviews.find(params[:id])

        if @review.destroy
          flash[:notice] = t('.success')
        else
          flash[:aler] = t('.fail')
        end
        redirect_to movie_reviews_path
      end

      private

      def review_params
        params.require(:review).permit(:body)
      end
    end
  end
end

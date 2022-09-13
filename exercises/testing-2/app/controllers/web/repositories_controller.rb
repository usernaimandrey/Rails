# frozen_string_literal: true

module Web
  class RepositoriesController < Web::ApplicationController
    def index
      @repositories = Repository.all
    end

    def new
      @repository = Repository.new
    end

    def show
      @repository = Repository.find params[:id]
    end

    def create
      # BEGIN
      link = permitted_params[:link]

      @repository = GitHubService.call(link)

      if @repository&.persisted?
        flash[:notice] = t('.success')
        redirect_to @repository
      else
        flash[:alert] = t('.failure')
        redirect_to new_repository_path
      end
      # END
    end

    def edit
      @repository = Repository.find params[:id]
    end

    def update
      @repository = Repository.find params[:id]

      if @repository.update(permitted_params)
        redirect_to repositories_path, notice: t('success')
      else
        flash[:notice] = t('fail')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @repository = Repository.find params[:id]

      if @repository.destroy
        redirect_to repositories_path, notice: t('success')
      else
        redirect_to repositories_path, notice: t('fail')
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:link)
    end
  end
end

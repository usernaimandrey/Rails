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
      @repository = Repository.new(permitted_params)

      if @repository.save
        RepositoryLoaderJob.perform_later(@repository.id)
        redirect_to @repository, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
      # END
    end

    def update
      # BEGIN
      @repository = Repository.find_by(params[:id])

      if @repository.present?
        RepositoryLoaderJob.perform_later(@repository.id)
        flash[:notice] = t('.success')
      else
        flash[:alert] = t('.failure')
      end
      redirect_to repositories_path
      # END
    end

    def update_repos
      # BEGIN
      repositories = Repository.all
      repositories.each do |repository|
        RepositoryLoaderJob.perform_later(repository.id)
      end
      redirect_to repositories_path
      # END
    end

    def destroy
      @repository = Repository.find params[:id]

      if @repository.destroy
        redirect_to repositories_path, notice: t('success')
      else
        redirect_to repositories_path, notice: t('failure')
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:link)
    end
  end
end

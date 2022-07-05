# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.limit(15).order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    params = task_params
    completed = params[:status] != 'new'
    @task = Task.new(params.merge({ completed: completed }))

    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    params = task_params
    completed = params[:status] != 'new'

    if @task.update(params.merge({ completed: completed }))
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path
    else
      redirect_to task_path(@task)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status, :creator, :performer)
  end
end

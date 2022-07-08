# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.limit(15).order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)

    if @task.save
      redirect_to task_path(@task), notice: 'Task create successfully'
    else
      flash[:alert] = 'Something went wrong'
      render :new,  status: :unprocessable_entity
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

    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task update successfully'
    else
      flash[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: 'Task destroy successfully'
    else
      flash[:alert] = 'Something went wrong'
      redirect_to task_path(@task), status: :unprocessable_entity
    end
  end

  private

  def task_params
    task_params = params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
    completed = task_params[:status] == 'closed'
    task_params.merge({ completed: completed })
  end
end

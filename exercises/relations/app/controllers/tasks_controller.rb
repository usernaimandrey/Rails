# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.last_tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to task_path(@task), notice: 'Task created!'
    else
      flash[:alert] = 'Something went wrong'
      render :new, status: :unprocessable_entity
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
      redirect_to task_path(@task), notice: 'Task updated!'
    else
      flash[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      redirect_to tasks_path, notice: 'Task deleted!'
    else
      flash[:alert] = 'Something went wrong'
      redirect_to task_path(@task), status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status_id, :user_id)
  end
end

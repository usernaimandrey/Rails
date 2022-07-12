# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :task, only: %i[show edit update destroy]

  def index
    @tasks = Task.find_tasks
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

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task updated!'
    else
      flash[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: 'Task deleted!'
    else
      flash[:alert] = 'Something went wrong'
      redirect_to task_path(@task), status: :unprocessable_entity
    end
  end

  private

  def task_params
    task_params = params.require(:task).permit(:name, :description, :status_id, :user_id)
    user = User.find(task_params[:user_id])
    status = Status.find(task_params[:status_id])
    task_params.except(:status_id).except(:user_id).merge({ user: user, status: status })
  end

  def task
    @task = Task.find_task(params[:id])
  end
end

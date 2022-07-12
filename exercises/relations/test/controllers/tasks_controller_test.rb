# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:new)
  end
  test '#index' do
    get tasks_path

    assert_response :success
  end

  test '#show' do
    get task_path(@task)

    assert_response :success
  end

  test '#new' do
    get new_task_path

    assert_response :success
  end

  test '#create' do
    task = {
      name: 'Task one',
      description: 'description one',
      status_id: statuses(:new).id,
      user_id: users(:vasy).id
    }

    post tasks_path, params: { task: task }

    new_task = Task.find_by(task)
    assert { new_task }
    assert_redirected_to task_path(new_task)
  end

  test '#create with invalid params' do
    task = {
      name: nil,
      description: 'description one',
      status_id: statuses(:new).id,
      user_id: users(:vasy).id
    }

    post tasks_path, params: { task: task }
    assert_response 422
    new_task = Task.find_by(task)
    assert_not(new_task)
  end

  test '#edit' do
    get edit_task_path(@task)

    assert_response :success
  end

  test '#update' do
    params = { status_id: statuses(:done).id, user_id: users(:pety).id }

    patch task_path(@task), params: { task: params }

    assert_redirected_to task_path(@task)
    update_task = @task.reload
    assert_equal(update_task.status.name, statuses(:done).name)
    assert_equal(update_task.user.name, users(:pety).name)
  end

  test '#destroy' do
    delete task_path(@task)
    assert_redirected_to tasks_path
    assert_not(Task.find_by(id: @task))
  end
end

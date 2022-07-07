# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:new)
  end

  test 'should get tasks' do
    get tasks_path

    assert_response :success
  end

  test 'should show task' do
    get task_path(@task)

    assert_response :success
    assert_match @task.name, @response.body
  end

  test 'should show new' do
    get new_task_path
    assert_response :success
  end

  test 'should create task' do
    task = {
      name: 'Task one',
      description: 'description one',
      status: 'new',
      creator: 'Jon',
      performer: 'Bill'
    }

    post tasks_path, params: { task: task }

    new_task = Task.find_by(task)
    assert { new_task }
    assert_redirected_to task_path(new_task)
  end

  test 'should not create task' do
    task = {
      name: nil,
      description: 'description one',
      status: 'new',
      creator: 'Jon111',
      performer: 'Bill'
    }

    post tasks_path, params: { task: task }
    assert_response 422
    new_task = Task.find_by(task)
    assert_not(new_task)
  end

  test 'should show edit' do
    get edit_task_path(@task)
    assert_response :success
  end

  test 'should update task' do
    params_update = { description: 'fixed test', performer: 'Andrey' }
    patch task_path(@task), params: { task: params_update }

    assert_redirected_to task_path(@task)
    update_task = @task.reload
    assert_equal(params_update[:description], update_task.description)
    assert_equal(params_update[:performer], update_task.performer)
  end

  test 'should destroy task' do
    delete task_path(@task)

    assert_response :redirect
    assert_redirected_to tasks_path
    assert_not(Task.find_by(id: @task))
  end
end

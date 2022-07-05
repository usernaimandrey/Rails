# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get home_page' do
    get root_path

    assert_response :success
    assert_select 'h1', 'Home Page'
  end

  test 'should get tasks' do
    get tasks_path

    assert_response :success
    assert_select 'h1', 'Tasks'
  end

  test 'should show task' do
    get task_path(tasks(:new))

    assert_response :success
    assert_select 'p', 'fixed bag'
    assert_select 'p', 'Status: new'
  end

  test 'should create task' do
    task = {
      name: 'Task one',
      description: 'description one',
      status: 'new',
      creator: 'Jon',
      performer: 'Bill'
    }

    get new_task_path
    assert_response :success

    post tasks_path, params: { task: task }

    assert_response :redirect
    assert_equal 'create', @controller.action_name
    follow_redirect!

    assert_match 'Task one', @response.body
    assert_select 'p', 'description one'
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
    assert_equal 'create', @controller.action_name
    assert_response :success

    assert_match 'only allows letters', @response.body
    assert_match 'can&#39;t be blank', @response.body
  end

  test 'should update task' do
    get edit_task_path(tasks(:new))
    assert_response :success

    assert_match 'Edit task: fixed', @response.body

    patch task_path(tasks(:new)), params: { task: { description: 'fixed test', performer: 'Andrey' } }

    assert_equal 'update', @controller.action_name
    assert_response :redirect
    follow_redirect!

    assert_select 'p', 'fixed test'
    assert_match 'Performer: Andrey', @response.body
  end

  test 'should destroy task' do
    delete task_path(tasks(:completed))

    assert_equal 'destroy', @controller.action_name
    assert_response :redirect
    follow_redirect!

    assert_select 'h1', 'Tasks'

    assert_raises(ActiveRecord::RecordNotFound) do
      get task_path(tasks(:completed))
    end
  end
end

# frozen_string_literal: true

class AddUserToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :user, null: false, foreign_key: { on_delete: :cascade }, index: true
  end
end

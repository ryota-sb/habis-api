class AddIsDoneToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :is_done, :boolean, default: false, null: false
  end
end

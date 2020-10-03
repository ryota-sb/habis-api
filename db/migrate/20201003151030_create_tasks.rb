class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :content
      t.boolean :is_done
      t.string :week
      t.time :notification_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

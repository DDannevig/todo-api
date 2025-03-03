class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :description, null: false
      t.boolean :completed, null: false, default: false
      t.bigint "todo_list_id", null: false
      t.index ["todo_list_id"]

      t.timestamps
    end
  end
end

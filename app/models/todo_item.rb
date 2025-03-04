class TodoItem < ApplicationRecord
  validates :completed, inclusion: [true, false]
  validates :description, presence: true

  belongs_to :todo_list

  after_update_commit :broadcast_todo_item

  scope :unfinished_items, -> { where(completed: false) }

  def broadcast_todo_item
    broadcast_update_to "todo_list_#{todo_list_id}", target: "todo_item_#{id}"
  end
end

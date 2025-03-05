class TodoList < ApplicationRecord
  validates :name, presence: true

  has_many :todo_items

  def complete_all_items!
    todo_items.unfinished_items.each(&:complete_task!)
  end
end

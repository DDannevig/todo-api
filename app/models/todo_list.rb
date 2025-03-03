class TodoList < ApplicationRecord
  validates :name, presence: true

  has_many :todo_items

  def complete_all_items
    byebug
  end
end

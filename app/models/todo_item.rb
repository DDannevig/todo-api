class TodoItem < ApplicationRecord
  validates :completed, inclusion: { in: [true, false] }
  validates :description, presence: true

  belongs_to :todo_list
end

class TodoItem < ApplicationRecord
  validates :completed, inclusion: [true, false]
  validates :description, presence: true

  belongs_to :todo_list
end

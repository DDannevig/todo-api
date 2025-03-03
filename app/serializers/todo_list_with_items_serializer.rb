class TodoListWithItemsSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :todo_items
end

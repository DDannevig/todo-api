class TodoItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :completed
end

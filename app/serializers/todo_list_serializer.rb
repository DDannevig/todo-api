class TodoListSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :todo_items, if: :option_todo_items?

  def todo_items
    object.todo_items
  end

  def option_todo_items?
    @instance_options[:option_name] == :with_items
  end
end

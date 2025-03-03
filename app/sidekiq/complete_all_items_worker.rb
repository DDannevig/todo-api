class CompleteAllItemsWorker
  include Sidekiq::Job

  def perform(todo_list_id)
    todo_list = TodoList.find(todo_list_id)

    todo_list.complete_all_items!
  end
end

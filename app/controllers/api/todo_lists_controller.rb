module Api
  class TodoListsController < ApplicationController
    # POST /api/todolists
    def create
      todo_list = TodoList.create!(name: params.require(:name))

      render json: todo_list, status: :ok
    end

    # GET /api/todolists
    def index
      render json: TodoList.all, status: :ok
    end
  end
end

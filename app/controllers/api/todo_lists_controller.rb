module Api
  class TodoListsController < ApplicationController
    # POST /todolists
    def create
      todo_list = TodoList.create!(name: params.require(:name))

      render json: todo_list, status: :ok
    end

    # # GET /api/todolists
    # def index
    #   @todo_lists = TodoList.all

    #   respond_to :json
    # end
  end
end

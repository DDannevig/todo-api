module Api
  class TodoItemsController < ApplicationController
    # POST /api/todos
    def create
      todo_list = TodoItem.create!(create_params)

      respond_to do |format|
        format.json { render json: todo_list }
      end
    end

    private

    def todo_list
      TodoList.find(params[:todolist_id])
    end

    def create_params
      params.require(:description)
      params.permit(%i[description completed]).to_h.merge({ todo_list: todo_list })
    end
  end
end

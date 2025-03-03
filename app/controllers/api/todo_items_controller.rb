module Api
  class TodoItemsController < ApplicationController
    # POST /api/todolists/:todolist_id/todos
    def create
      new_list = TodoItem.create!(create_params)

      respond_to do |format|
        format.json { render json: new_list }
      end
    end

    # GET /api/todolists/:todolist_id/todos
    def index
      respond_to do |format|
        format.json do
          render json: todo_list.todo_items
        end
      end
    end

    # PUT /api/todolists/:todo_list_id/todos/:id
    def update
      todo_item = todo_list.todo_items.find(params[:id])
      todo_item.update!(update_params)

      respond_to do |format|
        format.json do
          render json: todo_item
        end
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

    def update_params
      params.require(:description)
      params.permit(%i[description completed])
    end
  end
end

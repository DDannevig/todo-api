module Api
  class TodoListsController < ApplicationController
    # POST /api/todolists
    def create
      todo_list = TodoList.create!(name: params.require(:name))

      respond_to do |format|
        format.json { render json: todo_list }
      end
    end

    # GET /api/todolists
    def index
      # Paginate with Kaminari
      @todo_lists = TodoList.all

      respond_to :json
    end

    # PUT /api/todolists/:id
    def update
      todo_list = TodoList.find(params[:id])
      todo_list.update!(name: params.require(:name))

      respond_to do |format|
        format.json { render json: todo_list }
      end
    end

    # DELETE /api/todolists/:id
    def destroy
      todo_list = TodoList.find(params[:id])
      todo_list.destroy!

      respond_to :json
    end
  end
end

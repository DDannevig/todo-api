class TodoListsController < ApplicationController
  before_action :todo_list, only: :show

  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to :html
  end

  # SHOW /todolists/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  private

  def todo_list
    @todo_list ||= TodoList.find(params['id'])
  end
end

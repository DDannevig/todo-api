Rails.application.routes.draw do
  namespace :api do
    resources :todolists, only: %i[create index update destroy], controller: :todo_lists do
      resources :todos, only: :create, controller: :todo_items
    end
  end

  resources :todo_lists, only: %i[index], path: :todolists
end

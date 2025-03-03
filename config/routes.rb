Rails.application.routes.draw do
  namespace :api do
    resources :todolists, only: %i[create index update destroy], controller: :todo_lists do
      resources :todos, only: %i[create index update destroy], controller: :todo_items
    end
  end

  resources :todo_lists, only: %i[index show], path: :todolists
end

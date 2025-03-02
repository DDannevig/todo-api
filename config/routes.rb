Rails.application.routes.draw do
  namespace :api do
    resources :todolists, only: %i[create index], controller: :todo_lists
  end

  resources :todo_lists, only: %i[index], path: :todolists
end

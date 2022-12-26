Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  require "sidekiq/web"

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root "pages#home"
  get :results, to: "pages#results"
  post :search, to: "pages#search"

  resources :bookshelves
  resources :books, only: %i[show] do
    resources :book_bookshelves, only: %i[create destroy]
  end
end

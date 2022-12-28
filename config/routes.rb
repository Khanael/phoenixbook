Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "pages#home"
  get :results, to: "pages#results"
  post :search, to: "pages#search"

  get :recommendations, to: 'pages#recommendations'



  resources :bookshelves
  resources :books, only: %i[show] do
    resources :book_bookshelves, only: %i[create destroy]
    resources :likes, only: %i[create]
  end
  resources :likes, only: %i[update destroy]
end

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")

  root "pages#home"
  resources :pages, only: %i[show]
  resources :bookshelves do
    resources :book_bookshelves, only: %i[create destroy]
  end
  post 'add_book', to: 'bookshelves#add_book_to_bookshelf'
end

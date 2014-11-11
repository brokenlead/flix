Flix::Application.routes.draw do

  root "movies#index"
  resource :session
  get "signin" => "sessions#new"
  get "signup" => "users#new"
  resources :users
  get "movies/filter/:scope" => "movies#index", as: "filtered_movies"
  resources :movies do
      resources :reviews
      resources :favorites
  end
  resources :genres
end

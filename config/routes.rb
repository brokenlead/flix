Flix::Application.routes.draw do
  resources :favorites

  root "movies#index"
  resource :session
  get "signin" => "sessions#new"
  get "signup" => "users#new"
  resources :users
  resources :movies do
      resources :reviews
  end
end

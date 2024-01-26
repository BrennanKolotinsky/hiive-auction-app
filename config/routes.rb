Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'item/index'
    end
  end
  devise_for :users
  root 'homepage#index'
  get '/*path' => 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

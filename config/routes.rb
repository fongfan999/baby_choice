Rails.application.routes.draw do

  mount Spina::Engine => '/'

  Spina::Engine.routes.draw do
    namespace :admin do
      resources :categories
    end

    root "categories#index"
    get "/search" => "articles#search"
    resources :articles, only: [:show]
    resources :categories, only: [:show]
  end
end

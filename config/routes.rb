Rails.application.routes.draw do

  Spina::Engine.routes.draw do
    namespace :spina do
      namespace :admin do
        get 'categories/index'
      end
    end

    root "articles#index"
    resources :articles, only: [:show]
    resources :categories, only: [:show]

    namespace :admin, path: Spina.config.backend_path do
      resources :categories
    end
  end

  mount Spina::Engine => '/'
end

Rails.application.routes.draw do

  Spina::Engine.routes.draw do
    root "articles#index"
    resources :articles, only: [:show, :index]
  end

   mount Spina::Engine => '/'

end

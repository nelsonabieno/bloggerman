Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users

  resources :users do
    resources :posts do
      resources :comments
    end
  end

  root to: redirect('/pages/home')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

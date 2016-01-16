Rails.application.routes.draw do
  root 'pages#home'
  devise_for :admins
  get 'about', to: 'pages#about'
  resources :categories, only: [:show] do
    resources :products, only: [:index, :show]
  end

  namespace :dashboard, as: :admin do
    get '/', to: 'admin#index'
    resources :categories do
      collection do
        post 'order'
      end
      resources :products
    end
  end


end

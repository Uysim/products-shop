Rails.application.routes.draw do
  root 'pages#home'
  devise_for :admins
  get 'about', to: 'pages#about'
  get 'search', to: 'pages#search'
  resources :categories, only: [:show] do
    resources :products, only: [:index, :show]
  end

  namespace :dashboard, as: :admin do
    get '/', to: 'admin#index'
    resources :categories do
      collection do
        post 'order'
      end
      resources :products do
        collection do
          post 'order'
        end
      end
    end

    resources :sliders
  end


end

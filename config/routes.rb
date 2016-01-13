Rails.application.routes.draw do
  root 'pages#home'
  devise_for :admins
  namespace :dashboard, as: :admin do
    get '/', to: 'admin#index'
    resources :categories do
      collection do
        post 'order'
      end
      resources :products
    end
  end

  namespace :api do
    resources :categories do

      resources :products
    end
  end
end

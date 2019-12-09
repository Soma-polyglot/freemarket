Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "products#index"
  # root to: "cards#edit"
  resources :users, only: [:edit,:show,:index]
  resources :products
  resources :mypage

  resources :users, only: [:edit,:show] do
    collection do 
      get 'signout'
    end
  end
  
  resources :products do
    collection do 
      get 'pagenotfound'
    end
  end


  resources :product_images, only: [:edit, :update, :destroy] do
    collection do
      post :upload
    end
  end

  resources :posts
  resources :cards, only: [:new, :create, :edit]
  resources :signup, only: [:create] do
    collection do
      get 'signup_link'
      get 'step1'
      get 'step2'
      get 'step3'
      get 'done' 
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
end

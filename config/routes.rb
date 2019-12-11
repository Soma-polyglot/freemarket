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

  
  resources :mypage

  resources :users, only: [:index,:edit,:show] do
    member do 
      get 'signout'
    end
  end
  
  resources :products do
    collection do 
      get 'pagenotfound'
      get 'done'
    end
    member do
      get 'purchase'
      post 'pay'
    end
  end


  resources :product_images do
    collection do
      post :upload
    end
  end

  resources :posts
  resources :cards
  resources :signup, only: [:create] do
    collection do
      get 'signup_link'
      get 'step1'
      get 'step2'
      get 'step3'
      get 'done' 
    end
  end

end

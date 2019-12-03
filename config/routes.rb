Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :products
  resources :product_images, only: [:edit, :update, :destroy] do
    collection do
      post :upload
    end
  end

  root to: "products#index"

  root to: "signup#signup_link"

  resources :cards, only: [:new, :create]
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

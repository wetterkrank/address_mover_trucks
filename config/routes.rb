# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  
  resources :trucks do
    resources :bookings, only: [ :new, :create ]
  end

  resources :bookings, only: [ :show, :update, :edit, :index, :destroy ]
end
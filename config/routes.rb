# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'trucks/show'
  get 'trucks/new'
  get 'trucks/create'
  devise_for :users
  root to: 'pages#home'
  
  resources :trucks do
    resources :bookings, only: [ :new, :create, :index ]
  end
end

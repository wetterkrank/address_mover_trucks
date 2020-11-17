Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :trucks do
    resources :bookings, only: [ :new, :create, :index, :edit, :update ]
  end

end

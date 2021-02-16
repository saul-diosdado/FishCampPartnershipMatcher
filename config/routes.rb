Rails.application.routes.draw do
  root 'profiles#index'
  resources :profiles do 
    member do
      get :delete
    end
  end
  #get 'ui/CreateProfile'
  #get 'ui/EditProfile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions do
    member do
      get :delete
    end
  end
end

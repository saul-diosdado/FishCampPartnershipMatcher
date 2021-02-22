Rails.application.routes.draw do
  root 'profiles#index'
  resources :profiles do 
    member do
      get :delete
    end
  end

  resources :answers do
    member do
      get :delete
    end
  end

  resources :preferences do
    member do
      get :delete
    end
  end

  resources :questions do
    member do
      get :delete
    end
  end
end

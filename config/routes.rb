Rails.application.routes.draw do
  get 'preference_forms/index'
  get 'preference_forms/new'
  get 'preference_forms/edit'
  get 'preference_forms/delete'
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

  resources :preference_forms do
    member do
      get :delete
    end
  end
end


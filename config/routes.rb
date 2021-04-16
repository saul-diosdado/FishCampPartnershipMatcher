# frozen_string_literal: true

Rails.application.routes.draw do
  get 'unapproved_user/index'
  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: %i[create edit update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'
  get '/confirm_email/:token' => 'email_confirmations#update', as: 'confirm_email'

  namespace :admin do
   
    resources :roles
    resources :users
    resources :preference_forms
    resources :profiles


    
  end
  root 'profiles#index'

  resources :users do 
    collection do
      get 'remove_all'
    end
  end
  
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
      get :submit
    end
  end

  resources :matches do
    member do
      get :delete
    end

    get 'edit_search'
    get 'edit_unmatched'
  end

  resources :support, only: [:index]
  get 'support/chair'
  get 'support/director'
  get 'support/admin'

  resources :public_forms, only: [:index]

  resources :personalities, only: [:index]
  get 'personalities/myersBriggs'
  get 'personalities/conflictManagement'
  get 'personalities/trueColors'
  get 'personalities/enneagram'
  get 'personalities/conflictManagementFox'
end

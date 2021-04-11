# frozen_string_literal: true

Rails.application.routes.draw do
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
    resources :answers
    resources :choices
    resources :preferences
    resources :preference_forms
    resources :profiles
    resources :questions
    resources :roles
    resources :users

    root to: 'answers#index'
  end
  root 'profiles#index'

  resources :profiles do
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

  resources :matches do
    member do
      get :delete
    end

    get 'edit_search'
    get 'edit_unmatched'
  end

  resources :public_forms, only: [:index]

  resources :personalities, only: [:index]
  get 'personalities/myersBriggs'
  get 'personalities/conflictManagement'
  get 'personalities/trueColors'
  get 'personalities/enneagram'
  get 'personalities/conflictManagementFox'
end

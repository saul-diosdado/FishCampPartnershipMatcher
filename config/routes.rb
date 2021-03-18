# frozen_string_literal: true

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

  resources :preference_forms do
    member do
      get :delete
    end
  end

  resources :public_forms, only: [:index]
end

# config/routes.rb

Rails.application.routes.draw do
  devise_for :users

  # Dashboard
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  root 'dashboard#index' # Set dashboard as root

  # Projects
  resources :projects do
    resources :proposals, only: [:new, :create]
  end

  # Proposals
  resources :proposals do
    resources :comments, only: [:create, :destroy]
    member do
      patch :submit_review
      patch :approve
      patch :reject
      patch :schedule
      post :revert_version
    end
    collection do
      get :export
    end
  end

  # Slack Integration
  post '/slack/commands', to: 'slack#commands'
  post '/slack/interactions', to: 'slack#interactions'

  # Admin Namespace
  namespace :admin do
    resources :proposals
    resources :projects
  end

  # Sidekiq Web UI (only for development)
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
end

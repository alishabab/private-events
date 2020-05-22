# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[new create show]
  resources :events, only: %i[index new create show] do
    resources :invitations, only: %i[new create]
  end

  get 'login'=>'sessions#new'
  post 'login' => 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'
end

Flixter::Application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  
  get 'privacy', to: 'static_pages#privacy'
  get 'team', to: 'static_pages#team'
  get 'careers', to: 'static_pages#careers'

  resource :dashboard, only: [:show]
  
  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end

  resources :courses, only: [:index, :show]
  resources :lessons, only: [:show]
  
  namespace :instructor do
    resources :lessons, only: [:update]
    resources :sections, only: [:update]
    resources :sections, only: [] do
      resources :lessons, only: [:create]
    end
    resources :courses, only: [:new, :create, :show, :index, :destroy] do
      resources :sections, only: [:create]
    end
    #resources :courses, only: [:index]
  end
end
Flixter::Application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  
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
      resources :lessons, only: [:new, :create]
    end
    resources :courses, only: [:new, :create, :show, :index, :destroy] do
      resources :sections, only: [:create]
    end
    #resources :courses, only: [:index]
  end
end
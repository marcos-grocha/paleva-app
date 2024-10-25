Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  # Defines my routes
  root "pa_leva#index"
  devise_for :user_owners

  resources :establishments, only: [ :new, :create, :show ]
  resources :dishes, only: [ :index, :new, :create ]
  resources :beverages, only: [ :index, :new, :create ]
end

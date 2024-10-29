Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  # Defines my routes
  root "pa_leva#index"
  devise_for :user_owners

  resources :establishments, only: [ :new, :create, :show ] do
    get "search", on: :collection
  end
  resources :dishes, only: [ :index, :new, :create, :show, :edit, :update ] do
    patch "change_status", on: :member
  end
  resources :beverages, only: [ :index, :new, :create, :show, :edit, :update ] do
    patch "change_status", on: :member
  end
end

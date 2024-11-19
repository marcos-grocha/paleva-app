Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  # Defines my routes #
  root "pa_leva#start"
  get '/pa-leva/session', to: "pa_leva#session"
  get '/pa-leva/details', to: "pa_leva#details"

  devise_for :user_owners
  devise_for :user_employees
  resources :employee_pre_registrations, only: [ :index, :new, :create ]

  resources :establishments, only: [ :new, :create, :show, :edit, :update ] do
    get "search", on: :collection
  end

  resources :dishes, only: [ :index, :new, :create, :show, :edit, :update ] do
    resources :portions, only: [ :new, :create, :show, :edit, :update ]
    resources :additional_features, only: [ :new, :create, :edit, :update ]
    patch "change_status", on: :member
    get "search", on: :collection
  end

  resources :beverages, only: [ :index, :new, :create, :show, :edit, :update ] do
    resources :portions, only: [ :new, :create, :show, :edit, :update ]
    patch "change_status", on: :member
  end

  resources :menus, only: [ :index, :new, :create, :show, :edit, :update ] do
    post "add_item_to_order", on: :member
    delete "remove_item_from_order", on: :member
  end

  resources :orders, only: [ :index, :new, :create, :show ]

  namespace :api do
    namespace :v1 do
      resources :establishments, param: :code, only: [] do
        resources :orders, param: :order_code, only: [:index, :show, :update]
      end
    end
  end

end

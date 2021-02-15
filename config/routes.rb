Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    resources :accounts, only: %i[create]
    resources :resources, only: %i[index show]
    resource :session, only: %i[create show]
    resources :subjects, only: %i[index]
    resources :quiz_sessions, only: %i[create show]
  end
end

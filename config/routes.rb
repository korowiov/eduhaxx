Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    resources :resources, only: %i[index show]
    resources :subjects, only: %i[index]
  end
end

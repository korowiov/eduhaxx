Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    resources :accounts, only: %i[create]
    resources :resources, only: %i[index show]
    resource :session, only: %i[create show]
    resources :subjects, only: %i[index]
    resources :quiz_sessions, only: %i[create show] do
      member do
        get '/question/:question_number', to: 'quiz_sessions/quiz_questions#show'
        post '/question/:question_number/answer', to: 'quiz_sessions/quiz_question_answers#create'
      end
    end
  end
end

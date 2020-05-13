Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
   }
  root 'tweets#index'
  resources :tweets do

    post 'retweet'
    post 'like'
  end

  namespace :api do
   resources :news, only: [:index, :date]

 end

get 'api/:date_in/:date_out', to: 'api/news#date', as: "date"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end

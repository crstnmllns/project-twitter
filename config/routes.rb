Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
   }
  root 'tweets#index'
  resources :tweets do
    post 'retweet'
    post 'like'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end

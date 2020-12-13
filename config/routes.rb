Rails.application.routes.draw do
  root 'posts#index'
  get 'line_bots/client'
  get 'line_bots/callback'
  resources :posts
  post '/callback', to: 'line_bots#callback'
end

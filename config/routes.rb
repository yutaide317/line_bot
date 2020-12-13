Rails.application.routes.draw do
  root 'posts#index'
  get 'line_bots/client'
  get 'line_bots/collback'
  resources :posts
  post '/callback', to: 'line_bots#callback'
end

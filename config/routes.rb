Rails.application.routes.draw do
  get 'line_bots/client'
  get 'line_bots/collback'
  resources :posts
  post '/callback', to: 'linebot#callback'
end
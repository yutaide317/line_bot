Rails.application.routes.draw do
  resources :posts
  post '/callback', to: 'linebot#callback'
end

Rails.application.routes.draw do
  post 'bodem/scanner'
  root 'pages#home'
  get '/likes', to: 'pages#likes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

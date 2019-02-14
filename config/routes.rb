Rails.application.routes.draw do
  # root 'searches#search'
  get '/search', to: 'searches#search'
  # post '/search', to: 'searches#foursquare'
  
  get '/success', to: 'application#success'
  get '/auth', to: 'sessions#create'
  root 'searches#meetups'
end

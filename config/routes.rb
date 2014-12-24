Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'spotify#callback'
  get '/spotify/playlists', to: 'spotify#playlists'
  post '/spotify/results', to: 'spotify#results'

  root 'default#index'
end

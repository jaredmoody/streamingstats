Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'spotify#callback'
  get '/spotify/generate',  to: 'spotify#generate'
  get '/spotify/results',   to: 'spotify#results'
  get '/spotify/progress',  to: 'spotify#progress'

  root 'default#index'
end

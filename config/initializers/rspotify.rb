if ENV['SPOTIFY_ID']
  RSpotify::authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
end

class SpotifyController < ApplicationController
  before_action :set_user, except: [:callback]

  def callback
    session[:user] = RSpotify::User.new(request.env['omniauth.auth']).to_hash
    redirect_to action: :playlists
  end

  def playlists
    @playlists = @spotify_user.playlists
  end

  def results
    @report = Report.find_by_user_name(@spotify_user.id)
    unless @report
      @report = Report.create(
        spotify_user: @spotify_user,
        playlists: params[:playlists]
      )
    end
  end

  private

  def set_user
    if session[:user]
      @spotify_user = RSpotify::User.new(session[:user])
      logger.warn @spotify_user.id
    else
      redirect_to root_path
    end
  end
end

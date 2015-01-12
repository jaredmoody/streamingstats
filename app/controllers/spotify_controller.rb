class SpotifyController < ApplicationController
  before_action :set_user, except: [:callback]
  before_action :find_report

  def callback
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    redirect_to action: 'generate'

    unless @report
      @report = Report.create(user_name: @spotify_user.id, spotify_user: @spotify_user)
      ReportGenerateJob.perform_later(@report)
    end
  end

  def generate
  end

  def progress
    render json: @report.complete
  end

  def results
  end

  private

  def find_report
    @report = Report.find_by_user_name(@spotify_user.id)
    redirect_to action: 'results' if @report.complete?
  end

  def set_user
    if session[:user]
      @spotify_user = RSpotify::User.new(session[:user])
    else
      redirect_to root_path
    end
  end
end

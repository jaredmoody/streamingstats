class SpotifyController < ApplicationController

  before_action :find_report, except: [:callback]

  def callback
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:user] = @spotify_user.id
    find_report

    unless @report
      @report = Report.create(user_name: @spotify_user.id, spotify_user: @spotify_user)
      ReportGenerateJob.perform_later(@report)
    end
    redirect_to action: 'generate'
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
    if session[:user]
      @report = Report.find_by_user_name(session[:user])
      redirect_to action: 'results' if @report.complete? and return
    else
      redirect_to root_path
    end
  end
end

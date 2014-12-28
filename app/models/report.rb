class Report < ActiveRecord::Base
  attr_writer :spotify_user
  attr_writer :playlists

  serialize :data

  before_create :build

  def build
    self.user_name = @spotify_user.id
    self.num_playlists = @playlists.size

    @tracks = {}
    retries = 0
    @spotify_playlists = @spotify_user.playlists
    @spotify_playlists.each do |playlist|
      if playlist.owner.id != @spotify_user.id || !@playlists.include?(playlist.id)
        logger.warn "Skipping #{playlist.name}"
        next
      end
      begin
        logger.warn "Getting tracks for playlist: #{playlist.name}"
        0.upto(playlist.total/100) do |batch|
          logger.warn "Batch: #{batch}"
          playlist.tracks(offset: batch*100).each do |track|
            added = playlist.tracks_added_at[track.id]
            if @tracks[track.id].nil? || @tracks[track.id] < added
              @tracks[track.id] = added
            end
          end
        end
      rescue Exception => e
        logger.warn "*** #{playlist.name} failed: #{e}"
        next
      end
    end

    self.num_tracks = @tracks.size

    ### Start calendar ###

    @calendar = {}

    @tracks.each do |key, value|
      date_key = value.beginning_of_month.to_date
      @calendar[date_key] ||= 0
      @calendar[date_key] += 1
    end

    @calendar = @calendar.to_a.sort!

    # make sure there are no missing months
    date = @calendar.first[0] + 1.month
    end_date = Date.today.last_month.beginning_of_month
    while date < end_date do
      unless @calendar.index{|x| x[0] == date}
        @calendar << [date, 0]
      end
      date = date + 1.month
    end

    @calendar.sort!

    # format labels
    @calendar.collect!{|item| [item[0].strftime("%B %Y"), item[1]]}

    self.data = @calendar

    ### end calendar

    self.average_tracks = @calendar.collect(&:last).inject{ |sum, el| sum + el }.to_f / @calendar.size
  end
end

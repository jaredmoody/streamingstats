class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :user_name
      t.integer :average_tracks
      t.integer :num_tracks
      t.integer :num_playlists
      t.text :data
    end

    add_index :reports, :user_name, unique: true
  end
end

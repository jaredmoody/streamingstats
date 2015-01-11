class AddCredentialsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :credentials, :text
  end
end

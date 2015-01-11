class AddCompleteToReports < ActiveRecord::Migration
  def change
    add_column :reports, :complete, :boolean, default: false, after: :user_name
  end
end

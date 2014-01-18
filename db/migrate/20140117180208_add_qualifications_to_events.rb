class AddQualificationsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :qualifications, :text
  end
end

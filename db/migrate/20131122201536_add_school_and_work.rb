class AddSchoolAndWork < ActiveRecord::Migration
  def change
    add_column :users, :school, :string
    add_column :users, :work, :string
  end
end

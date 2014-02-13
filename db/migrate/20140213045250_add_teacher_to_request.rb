class AddTeacherToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :teacher, :integer
  end
end

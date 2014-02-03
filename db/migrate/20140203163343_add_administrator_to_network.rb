class AddAdministratorToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :admin, :integer
  end
end

class AddLogo < ActiveRecord::Migration
  def change
    add_column :networks, :logo, :string
  end
end

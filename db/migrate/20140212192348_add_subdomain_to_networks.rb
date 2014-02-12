class AddSubdomainToNetworks < ActiveRecord::Migration
  def change
    add_column :networks, :subdomain, :string
  end
end

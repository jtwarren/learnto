class CreateNetworkUsers < ActiveRecord::Migration
  def change
    create_table :network_users do |t|
      t.references :network, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

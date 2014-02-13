class CreateRequestUsers < ActiveRecord::Migration
  def change
    create_table :request_users do |t|
      t.references :request, index: true
      t.references :user, index: true
      
      t.timestamps
    end
  end
end

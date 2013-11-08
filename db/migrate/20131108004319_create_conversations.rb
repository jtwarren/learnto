class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :lesson, index: true
      t.timestamps
    end
  end
end

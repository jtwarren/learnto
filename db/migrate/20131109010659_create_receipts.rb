class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.timestamps
    end
  end
end

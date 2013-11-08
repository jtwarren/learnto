class DropReceipts < ActiveRecord::Migration
  def change
    drop_table :receipts
    drop_table :notifications
    drop_table :conversations
  end
end

class AddReadToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :read, :boolean, :default=> false
  end
end

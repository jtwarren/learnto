class DropTableTokens < ActiveRecord::Migration
  def change
    drop_table :tokens
  end
end

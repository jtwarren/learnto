class ChangeBody < ActiveRecord::Migration
  def change
    change_column :messages, :body, :text
  end
end

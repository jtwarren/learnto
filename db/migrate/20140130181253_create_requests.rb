class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.string :picture
      t.boolean :approved
      t.boolean :hidden
      t.references :user
      t.timestamps
    end
  end
end

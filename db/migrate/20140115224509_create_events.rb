class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :user, index: true
      t.string :picture
      t.boolean :approved, :default => false
      t.datetime :starts_at

      t.timestamps
    end
  end
end

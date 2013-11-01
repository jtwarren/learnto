class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :message
      t.boolean :thumb
      t.references :user, index: true
      t.references :skill, index: true
      t.timestamps
    end
  end
end

class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :email
      t.references :skill, index: true

      t.timestamps
    end
  end
end

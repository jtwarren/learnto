class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :title
      t.text :qualifications
      t.references :user, index: true

      t.timestamps
    end
  end
end

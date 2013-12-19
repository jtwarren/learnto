class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.boolean :paid, default: false
      t.references :users
      t.references :lessons
      t.timestamps
    end
  end
end

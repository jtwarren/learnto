class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.text :subject
      t.integer :sender
      t.integer :receiver
      t.boolean :read
      t.references :conversation, index: true
      t.timestamps
    end
  end
end

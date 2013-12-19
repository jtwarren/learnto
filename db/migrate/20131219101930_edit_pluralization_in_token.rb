class EditPluralizationInToken < ActiveRecord::Migration
  def change
    remove_reference :tokens, :users
    remove_reference :tokens, :lessons
    add_reference :tokens, :user
    add_reference :tokens, :lesson
  end
end

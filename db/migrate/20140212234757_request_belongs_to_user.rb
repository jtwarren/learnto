class RequestBelongsToUser < ActiveRecord::Migration
  def change
    add_reference :users, index: true
  end
end

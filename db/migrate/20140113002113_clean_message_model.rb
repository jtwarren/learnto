class CleanMessageModel < ActiveRecord::Migration
  def change
    add_reference :messages, :user, index: true

    Message.all.each do |message|
      message.update(user_id: message.sender)
    end

    remove_column :messages, :subject

    remove_column :messages, :sender

    remove_column :messages, :receiver
    
    remove_column :messages, :read
  end
end

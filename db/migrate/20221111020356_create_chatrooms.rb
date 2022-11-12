class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.integer :chat_sender_id
      t.integer :chat_receiver_id
      t.timestamps
    end
  end
end

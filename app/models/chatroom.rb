class Chatroom < ApplicationRecord
    belongs_to :chat_sender, class_name: :User
    belongs_to :chat_receiver, class_name: :User
    has_many :messages
end

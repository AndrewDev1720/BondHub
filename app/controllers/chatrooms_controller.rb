class ChatroomsController < ApplicationController
    before_action :require_user
    def new

    end

    def create
        if(!current_user.chat_receivers.include?(User.find(params[:chat_receiver_id])))
            @chatroom = Chatroom.create!(chatroom_params())
            @chatroom2 = Chatroom.create!(chat_sender_id: params[:chat_receiver_id], chat_receiver_id: params[:chat_sender_id])
        else
            @chatroom = current_user.chatrooms.where(chat_receiver_id: params[:chat_receiver_id]).first
        end
        redirect_to chatroom_path(@chatroom.id)
    end

    def index
        @message = Message.new
    end
    
    def show
        @message = Message.new
        @messages = Chatroom.find(params[:id]).messages
    end

    private def chatroom_params()
        params.permit(:chat_sender_id, :chat_receiver_id)
    end
end

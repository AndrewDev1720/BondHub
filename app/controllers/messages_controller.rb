class MessagesController < ApplicationController
    before_action :require_user

    def create
        message = current_user.messages.build(message_params)
        receiver = User.find(Chatroom.find(params[:message][:chatroom_id]).chat_receiver_id)
        chatroom2 = Chatroom.where(chat_sender_id: receiver.id, chat_receiver_id: current_user.id).first
        current_user.messages.build(body: params[:message][:body], chatroom_id: chatroom2.id).save;
        if message.save
            ActionCable.server.broadcast("chatroom_channel",{mod_message: message_render(message)})
            
            # ActionCable.server.broadcast(
            #     "chatroom_channel",
            #     {
            #       id: message.id,
            #       body: message.body,
            #     }
            #   )
            # redirect_to chatroom_path(params[:message][:chatroom_id].to_i)
        end
    end
  
    private
  
    def message_params
        params.require(:message).permit(:body, :chatroom_id)
    end

    def message_render(message)
        render(partial: 'message', locals: {message: message})
      end
end

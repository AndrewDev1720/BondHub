class FriendshipsController < ApplicationController
    def create
        friendship = Friendship.create!(friendship_params())
        redirect_to user_path(params[:friend_id])
        current_user.friend_requests.where(requestor_id: current_user.id).delete_all
        current_user.friend_requests.where(receiver_id: current_user.id).delete_all
    end

    def destroy
        target = params[:friend_b_id].to_i
        if(target != 0)
            current_user.friendships.where(user_id: current_user.id, friend_id: target).delete_all
            User.find(target).friendships.where(user_id: target,friend_id: current_user.id).delete_all
            redirect_to user_path(target)
        else
            target = params[:id].to_i
            Friendship.find(target).delete
        end
    end
    
    private def friendship_params()
        params.permit(:user_id, :friend_id)
    end

end
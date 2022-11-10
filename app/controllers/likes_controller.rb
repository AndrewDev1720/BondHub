class LikesController < ApplicationController
    def create
        Like.create!(likesParams())
        redirect_to articles_path
    end

    def destroy
        params[:id] ? deletingLike = Like.find(params[:id].to_i).delete : Like.where(user_id: current_user, likable_id: params[:likable_id], likable_type: params[:likable_type]).delete_all
        redirect_to articles_path
    end

    private def likesParams()
        params.permit(:user_id, :likable_id, :likable_type)
    end
end
 
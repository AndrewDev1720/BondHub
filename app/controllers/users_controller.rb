class UsersController < ApplicationController
  before_action(:getUser, only: [:show, :edit, :update, :destroy, :show_friends])
  before_action(:check_owner, only: [:edit, :update])



  def show
    @friend_request = FriendRequest.new()
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    # @comments = @user.comments
    @comment = Comment.new()
  end

  def new
    @user = User.new()
  end

  def index
    @users = User.all
  end

  def show_friends
    @users = @user.getFriends()
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     # session[:user_id] = @user.id
  #     flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
  #   return redirect_to articles_path
  #   else
  #     render 'new'
  #   end
  # end

  # def edits
  # end

  # def update
  #   if @user.update(user_params)
  #     flash[:notice] = "Congrats #{@user.username}, you have successfully updated your information!" 
  #     # byebug
  #     return redirect_to user_path(@user)
  #   else
  #     render 'edit'
  #   end
  # end

  # def edit
  # end

  def destroy
    @user.destroy
    # session[:user_id] = nil
    flash[:notice] = "Account and all associated articles have successfully deleted"
    redirect_to root_path
  end

  private def user_params()
    params.require(:user).permit(:username, :email, :password, :avatar)
  end

  private def getUser()
    @user = User.find(params[:id])
  end

  private def check_owner()
    if !(logged_in?() && current_user.id == @user.id)
      flash[:alert] = "You do not have access to that directory"
      redirect_to user_path(@user.id)
    end
  end
end
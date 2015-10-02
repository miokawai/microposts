class UsersController < ApplicationController
  def edit
    unless  logged_in?
     return redirect_to root_url
   end
   @user = User.find(params[:id])
 end
    
  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.page(params[:page]).per(5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       session[:user_id] = @user.id
       flash[:success] = "Welcome to the Sample App, #{@user.name}!!"
      redirect_to @user 
    else
      render 'new'
    end
  end

 def update
    @user = User.find(params[:id])
    if @user != current_user
      return redirect_to root_url
    end
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
<<<<<<< HEAD

  
  def edit
=======
  def followings
>>>>>>> master
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end
  def index
    @users = User.page(params[:page]).per(10).order(:id)
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :comment, :website)
  end
end
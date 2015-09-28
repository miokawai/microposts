class UsersController < ApplicationController
  def edit
    @user = User.edit
  end
    
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "Welcome to the Sample App, #{@user.name}!!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

 def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :comment, :website)
  end
end
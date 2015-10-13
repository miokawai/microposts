class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @microposts = current_user.microposts.build(micropos_tparmas)
    if @microposts.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
def post_params
    params.require(:post).permit(:body).merge(user_id: current_user.id)
end
private
def microposts_parmas
  params.require(:micropost).permit(:content)
end
end

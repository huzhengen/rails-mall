class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password])
    if user
      update_browser_uuid user.uuid
      flash[:notice] = '登陆成功！'
      redirect_to root_path
    else
      flash[:notice] = '登陆失败！'
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = "退出成功！"
    redirect_to root_path
  end

end

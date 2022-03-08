class UsersController < ApplicationController
  def new
    @is_using_email = true
    @user = User.new
  end

  def create
    @is_using_email = (params[:user] and !params[:user][:email].nil?)
    @user = User.new(create_params)
    @user.uuid = session[:user_uuid]
    update_browser_uuid @user.uuid
    if @user.save
      flash[:notice] = '注册成功！请登录！'
      redirect_to new_session_path
    else
      render action: :new
    end
  end

  def index

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def create_params
    params.require(:user).permit(:email, :password, :password_confirmation, :cellphone, :token)
  end
end

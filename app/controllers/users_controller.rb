class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    @user.uuid = session[:user_uuid]
    if @user.save
      flash[:notice] = '注册成功！'
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

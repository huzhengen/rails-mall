class ApplicationController < ActionController::Base
  before_action :set_browser_uuid

  protected

  def fetch_home_data
    @categories = Category.grouped_data
  end

  def set_browser_uuid
    uuid = cookies[:user_uuid]
    unless uuid
      if logged_in?
        uuid = current_user.uuid
      else
        uuid = RandomCode.generate_utoken
      end
    end
    update_browser_uuid uuid
  end

  def update_browser_uuid uuid
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
  end
end

class ApplicationController < ActionController::Base
  protected

  def fetch_home_data
    @categories = Category.grouped_data
  end
end

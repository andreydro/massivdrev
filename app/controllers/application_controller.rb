class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    orders_path if resource.class == User
  end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class TamedBeastController < ApplicationController
  
  layout 'application'    
  skip_before_filter :require_not_admin 
  
  helper :all
  helper_method :current_page, :forum_admin?, :logged_in?
  before_filter :set_language
  # before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  # 
  # # See ActionController::RequestForgeryProtection for details
  # # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => 'e125a4be589f9d81263920581f6e4182'
  # 
  # # Filter password parameter from logs
  # filter_parameter_logging :password     
  
  def current_page
    @page ||= params[:page].blank? ? 1 : params[:page].to_i
  end

  private

  def set_language
    I18n.locale = :en || I18n.default_locale
  end 
  
  def forum_admin_required
    unless current_user.forum_admin
      flash[:notice] = "You don't have permission to access this page"
      redirect_to forums_path
    end
  end
  
  def forum_admin?
    current_user && current_user.forum_admin
  end
  
  def logged_in?
     !!current_user
  end

end

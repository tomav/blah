# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password
  helper_method :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  WHITELIST = ["127.0.0.1", "0.0.0.0.", "192.168.1", "88.162.117.170"]
  
  def check_whitelist
    if WHITELIST.include?(request.remote_ip)
      true
    else
      respond_to do |format|
        error_msg = "Your IP address not authorized"
        format.html { redirect_to "/blah.html", :status => 401 }
        format.xml { render :xml => { :error => error_msg }, :status => 401  }
        format.json { render :json => error_msg.to_json, :status => 401 }
      end
    end
  end
  
  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def check_session
    if current_user_session.blank?
      redirect_to "/login"
      flash[:notice] = "You have to login."
    end
  end
  
end

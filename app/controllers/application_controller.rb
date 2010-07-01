# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  WHITELIST = ["0.0.0.0.", "192.168.1", "88.162.117.170"]
  
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
  
end

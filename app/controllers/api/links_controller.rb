class Api::LinksController < ApplicationController
  
  before_filter :authenticate
  protect_from_forgery :except => :create
  
  # POST /api/links.xml
  def create
    if params[:long_url].blank?    
      long_url = params[:link][:long_url]
    else
      long_url = params[:long_url]
    end
    if params[:domain_id].blank?    
      domain_id = params[:link][:domain_id]
    else
      domain_id = params[:domain_id]
    end
    @link = Link.find_or_create_by_long_url_and_domain_id( long_url, domain_id )
    @link.ip_address = request.remote_ip

    respond_to do |format|
      if @link.save
        format.xml  { render :xml => @link, :status => :created, :location => @link }
        format.json  { render :json => @link, :status => :created, :location => @link }
      else
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
        format.json  { render :json => @link, :status => :created, :location => @link }
      end
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end
  end 
  

end

class Api::LinksController < ApplicationController
  
  # Requires basic http auth
  # POST XML to http://foo:bar@0.0.0.0:3000/api/links.xml with application/xml content-type
  # POST JSON to http://foo:bar@0.0.0.0:3000/api/links.json with application/json content-type
  
  before_filter :authenticate
  protect_from_forgery :except => :create
  
  # POST /api/links.xml
  # POST /api/links.json
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
    @link.format = request.format.to_s

    respond_to do |format|
      if @link.save
        format.xml  { render :xml => @link.to_xml(:only => [ :long_url, :short_url ]), :status => :created, :location => @link }
        format.json  { render :json => @link.to_json(:only => [ :long_url, :short_url ]), :status => :created, :location => @link }
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

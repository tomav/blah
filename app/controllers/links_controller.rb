class LinksController < ApplicationController
  
  before_filter :check_whitelist, :except => :redirect
  before_filter :check_session
  
  # GET /links
  # GET /links.xml
  def index
    #@links = Link.all
    @links = Link.find_all_by_user_id(current_user.id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
      format.json  { render :json => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
        
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    long_url = params.include?(:long_url) ? params[:long_url] : params[:link][:long_url]
    domain_id = params.include?(:domain_id) ? params[:domain_id] : params[:link][:domain_id]
    @link = Link.find_or_create_by_long_url_and_domain_id( long_url, domain_id )
    @link.ip_address = request.remote_ip
    @link.user_id = current_user.id

    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(@link, :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end
  
  def redirect
    @link = Link.find_by_short_url(request.url)
    unless @link.nil?
      @link.add_visit(request)
      redirect_to @link.long_url, { :status => 301 }
    else
      redirect_to :action => 'invalid'
    end
  end
  
  
  ##### oAuth
  #def login
  #  @consumer = OAuth::Consumer.new(
  #    OAUTH_TWITTER_KEY,
  #    OAUTH_TWITTER_SECRET,
  #    :site => OAUTH_TWITTER_URL
  #  )
  #  @request_token = @consumer.get_request_token(
  #    :oauth_callback => 'http://0.0.0.0:3000/login/callback'
  #  )
  #
  #  session[:request_token] = @request_token.token
  #  session[:request_secret] = @request_token.secret
  #
  #  redirect_to @request_token.authorize_url
  #end
  #
  #def callback
  #  @consumer = OAuth::Consumer.new(
  #    OAUTH_TWITTER_KEY,
  #    OAUTH_TWITTER_SECRET,
  #    :site => OAUTH_TWITTER_URL
  #  )
  #
  #  request_token = OAuth::RequestToken.new(
  #    @consumer,
  #    session[:request_token],
  #    session[:request_token_secret]
  #  )
  #
  #  access_token  = request_token.get_access_token(
  #    :oauth_verifier => params[:oauth_verifier]
  #  )
  #
  #  if access_token 
  #    logger.debug { "Got an access_token !" }
  #
  #    @user = JSON.parse(access_token.get("/account/verify_credentials.json", { 'Accept'=>'application/json' }).body)
  #    session[:user] = @user
  #    #logger.debug("Twitter Bird reply : #{@user.class}")
  #  end
  #
  #end
  
  
end

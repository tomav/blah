class LinksController < ApplicationController
  
  protect_from_forgery :secret => '2kdjnaLI8', :only => [:update, :delete, :create]
  
  # GET /links
  # GET /links.xml
  def index
    @links = Link.all

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
    @domains = Domain.all

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
  
end

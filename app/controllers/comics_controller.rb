class ComicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :latest]
  before_filter :require_author_status, :except => [:show, :index, :latest]

  # GET /comics
  # GET /comics.xml
  def index
    @comics = Comic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comics }
    end
  end
  
  # GET /comics/latest
  def latest
    params[:id] = 'latest'
    return show
  end

  # GET /comics/1
  # GET /comics/1.xml
  def show
    if params[:id] == 'latest'
      @comic = Comic.order('date').last
    else
      @comic = Comic.find(params[:id])
    end

    respond_to do |format|
      format.html { render :action => 'show' }# show.html.erb
      format.xml  { render :xml => @comic }
    end
  end

  # GET /comics/new
  # GET /comics/new.xml
  def new
    @comic = Comic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comic }
    end
  end

  # GET /comics/1/edit
  def edit
    @comic = Comic.find(params[:id])
  end

  # POST /comics
  # POST /comics.xml
  def create
    @comic = Comic.new(params[:comic])

    respond_to do |format|
      if @comic.save
        format.html { redirect_to(@comic, :notice => 'Comic was successfully created.') }
        format.xml  { render :xml => @comic, :status => :created, :location => @comic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comic.errors, :status => :unprocessable_entity }
      end
    end
  end
# PUT /comics/1
  # PUT /comics/1.xml
  def update
    @comic = Comic.find(params[:id])

    respond_to do |format|
      if @comic.update_attributes(params[:comic])
        format.html { redirect_to(@comic, :notice => 'Comic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comics/1
  # DELETE /comics/1.xml
  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy

    respond_to do |format|
      format.html { redirect_to(comics_url) }
      format.xml  { head :ok }
    end
  end
end

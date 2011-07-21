class ComicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :latest, :feed, :prev, :next]
  before_filter :require_author_status, :except => [:show, :index, :latest, :feed, :prev, :next]

  # GET /comics
  # GET /comics.xml
  def index
    @comics = Comic.order('date asc')

    # hide unpublished or future comics from everyone but authors.
    unless current_user && current_user.is_author
      @comics.collect! { |comic|
        if comic.publish && comic.date <= Time.now.to_date
          comic
        else
          nil
        end
      }
    end
    @comics.compact!

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comics }
    end
  end
  
  # GET /comics/1
  # GET /comics/1.xml
  def show
    @comic = Comic.find(params[:id])
    @comic.setup_next_and_prev
    show_comic
  end

  #takes whatever the id of the comic is, and get the next one.
  def next
    comic0 = Comic.find(params[:id])
    if comic0
      @comic = Comic.where("date > ?", comic0.date).order("date asc").first 
    else
      @comic = nil
    end
    show_comic
  end
  
  #takes whatever the id of the comic is, and get the next one.
  def prev
    comic0 = Comic.find(params[:id])
    @comic = Comic.where("date < ?", comic0.date).order("date desc").first if comic0
    @comic ||= comic0
    show_comic
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

  def feed
    @comics = Comic.order('date asc')
    
    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  private
  def show_comic
    # allow only authors to view unpublished comics. Everyone else goes to index.
    if !@comic || !( @comic.publish && @comic.date <= Time.now.to_date || (current_user && current_user.is_author) )
      params.delete :id
      redirect_to(:action => :index) and return
    end

    respond_to do |format|
      format.html { render :action => "show"}
      format.xml  { render :xml => @comic }
    end
  end
end

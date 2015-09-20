class ComicsController < ApplicationController
  UnprotectedActions = %w[ latest show show_by_slug index latest feed prev next ].freeze
  before_filter :authenticate_user!, :except => UnprotectedActions
  before_filter :require_author_status, :except => UnprotectedActions

  # GET /comics
  # GET /comics.xml
  def index
    @comics = get_comics
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comics }
    end
  end

  # GET /comics/latest
  def latest
    @comic = Comic.where(:publish => true).where("date <= ?",DateTime.now.to_date).order('date desc').first
    show_comic
  end

  # GET /comics/1
  # GET /comics/1.xml
  def show
    #deprecating the id based urls in favor of slug based urls.
    @comic = Comic.find(params[:id])
    redirect_to show_by_slug_path(@comic.slug), :status => :moved_permanently
  end

  # GET /slug_goes_here
  def show_by_slug
    @comic = Comic.find_by_slug(params[:slug])
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
    @comic = Comic.new(munged_comic_params)

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
      if @comic.update_attributes(munged_comic_params)
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
    @comics = get_comics
    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

private

  def show_comic
    #populate the first and last links
    @latest_comic = Comic.where(:publish => true)
                         .where("date <= ?",DateTime.now.to_date)
                         .order('date desc')
                         .first
    @first_comic = Comic.where(:publish => true)
                        .where( "date <= ?",DateTime.now.to_date)
                        .order('date asc')
                        .first

    unless (@comic.published? || (current_user && current_user.is_author))
      @comic = @latest_comic
    end

    respond_to do |format|
      format.html { render :action => "show"}
      format.xml  { render :xml => @comic }
    end
  end

  def get_comics
    if current_user && current_user.is_author
      comics = Comic.order('date asc')
    else
      # hide unpublished or future comics from everyone but authors.
      comics = Comic.where(:publish => true).where("date <= ?",DateTime.now.to_date).order('date asc')
    end
    comics
  end

  def any_comics?
    get_comics.any?
  end

  def munged_comic_params
    comic_params = params[:comic]
    tag_texts = comic_params.delete(:tags).split(',').map(&:strip)
    tags = tag_texts.map do |tag_text|
      Tag.find_by_tag(tag_text) || Tag.new(tag: tag_text)
    end
    comic_params[:tags] = tags
    comic_params
  end
end

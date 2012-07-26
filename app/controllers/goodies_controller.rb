class GoodiesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :require_author_status, :except => [:show, :index]

  # GET /goodies
  # GET /goodies.xml
  def index
    @goodies = Goody.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @goodies }
    end
  end

  # GET /goodies/1
  # GET /goodies/1.xml
  def show
    @goody = Goody.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @goody }
    end
  end

  # GET /goodies/new
  # GET /goodies/new.xml
  def new
    @goody = Goody.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @goody }
    end
  end

  # GET /goodies/1/edit
  def edit
    @goody = Goody.find(params[:id])
  end

  # POST /goodies
  # POST /goodies.xml
  def create
    @goody = Goody.new(params[:goody])

    respond_to do |format|
      if @goody.save
        format.html { redirect_to(@goody, :notice => 'Goody was successfully created.') }
        format.xml  { render :xml => @goody, :status => :created, :location => @goody }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @goody.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /goodies/1
  # PUT /goodies/1.xml
  def update
    @goody = Goody.find(params[:id])

    respond_to do |format|
      if @goody.update_attributes(params[:goody])
        format.html { redirect_to(@goody, :notice => 'Goody was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @goody.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /goodies/1
  # DELETE /goodies/1.xml
  def destroy
    @goody = Goody.find(params[:id])
    @goody.destroy

    respond_to do |format|
      format.html { redirect_to(goodies_url) }
      format.xml  { head :ok }
    end
  end
end

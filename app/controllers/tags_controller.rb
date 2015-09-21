class TagsController < ApplicationController
  UnprotectedActions = %w[ show index ].freeze
  before_filter :authenticate_user!, :except => UnprotectedActions
  before_filter :require_author_status, :except => UnprotectedActions

  def index
    @tags = Tag.all.select { |t| !t.nil? }
  end

  def show
    @tag = Tag.find_by_id(params[:id])
  end

  def new
    @tag = Tag.new
  end

  # post
  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect_to action: :index, notice: "tag saved"
    else
      redirect_to action: :index, error: "tag not saved :("
    end
  end

  def edit
    @tag = Tag.find_by_id(params[:id])
  end

  # put
  def update
    @tag = Tag.find_by_id(params[:id])
    if @tag.update_attributes(params[:tag])
      redirect_to action: :show, id: @tag.id,  note: "tag saved successfully"
    else
      redirect_to action: :show, id: @tag.id,  error: "tag not updated :("
    end
  end

  def destroy
    Tag.find_by_id(params[:id]).destroy
    redirect_to action: :index, notice: "tag destroyed"
  end

private

  def get_tags
  end
end

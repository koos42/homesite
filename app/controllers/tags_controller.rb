class TagsController < ApplicationController
  UnprotectedActions = %w[ show index ].freeze
  before_filter :authenticate_user!, :except => UnprotectedActions
  before_filter :require_author_status, :except => UnprotectedActions

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by_id(params[:id])
  end

private

  def get_tags
  end
end

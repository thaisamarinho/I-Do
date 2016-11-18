class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  def show
    @tag = Tag.find params[:id]
    # byebug
    @taggings = @tag.taggings
  end
end

class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @wedding = Wedding.find params[:wedding_id]
    @tag = Tag.find params[:tag_id]
    service = @wedding.services
    permitted_tag = @tag.taggings
    @taggings = []
    service.each do |s|
      @taggings.push(s.taggings[0]) if permitted_tag.include? s.taggings[0]
    end
  end
end

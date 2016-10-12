class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @title = "Links Tagged With '#{@tag.name}'"
    @links = @tag.taggings.collect { |t| t.taggable }
    render(:template => 'links/index')
  end
end

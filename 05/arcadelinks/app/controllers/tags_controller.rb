class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @title = "Links Tagged With '#{@tag.name}'"
    @links = @tag.taggings.collect { |t| t.taggable }.sort_by { |t| t.rate_average }.reverse
    render(:template => 'links/index')
  end
end

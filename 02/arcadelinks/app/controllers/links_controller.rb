class LinksController < ApplicationController
  def index
    @title = "Recently Added Resources"
    @links = Link.find(:all, :order => "created_at DESC")
  end

  def new
    @title = "New Arcade Resource"
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to(:action => 'index')
    else
      render(:action => 'new')
    end
  end

  def show
    @link = Link.find(params[:id])
    @title = @link.name
  end

  def tag
    @link = Link.find(params[:id])
    @link.tag_list.add(params[:tags].split(','))
    @link.save_tags
    redirect_to(link_path(@link))
  end
end

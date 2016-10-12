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

  def rate
    @user = User.find_or_create_by_ip_address(request.remote_ip)
    @link = Link.find(params[:id])

    @link.rates.find_by_user_id(@user.id).destroy if @link.rated_by?(@user)
    @link.rate(params[:stars], @user)

    render(:update) do |page|
      page.replace("link_#{@link.id}_rating",
                   :partial => "link_with_rating", :object => @link)
    end
  end
end

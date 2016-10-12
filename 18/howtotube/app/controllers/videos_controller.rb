class VideosController < ApplicationController
  def index
    @videos = Video.find(:all, :conditions => "converted IS NOT NULL")
  end

  def show
    @video = Video.find(params[:id])
    respond_to do |format|
      if @video.converted?
        format.html # render show.html.erb
        format.js { render(:partial => "player.html.erb") }
      else
        format.html do
          TranscodeWorker.asynch_convert_video(:video_id => @video.id) 
          # render show.html.erb
        end
        format.js { render(:nothing => true, :status => 415) } # no content (unsupported), working
      end
    end
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      flash[:notice] = "Thanks for uploading your video."
      redirect_to(video_path(@video))
    else
      flash[:error] = "Unable to save the video. Please check the form for errors."
      render(:action => 'new')
    end
  end
end

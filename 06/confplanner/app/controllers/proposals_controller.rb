class ProposalsController < ApplicationController
  before_filter :set_conference_talk, :only => [:show, :edit, :update]
  before_filter :authenticate, :only => [:index, :edit, :update]

  def new
    @conference_talk = ConferenceTalk.new
  end

  def create
    @conference_talk = ConferenceTalk.new(params[:conference_talk])
    if @conference_talk.save
      redirect_to(:action => 'show', :id => @conference_talk.id)
    else
      render(:action => 'new')
    end
  end

  def index
    @conference_talks = ConferenceTalk.find(:all, 
        :conditions => "state != 'rejected'", :order => "scheduled_at ASC")
  end

  def show; end
  def edit; end

  def update
    @conference_talk.update_attributes(params[:conference_talk])
    case(params[:state])
      when 'reject_talk':  @conference_talk.reject_talk!
      when 'accept_talk':  @conference_talk.accept_talk!
      when 'schedule_talk': @conference_talk.schedule_talk!
    end
    render(:action => 'edit')
  end

  private

    def set_conference_talk
      @conference_talk = ConferenceTalk.find(params[:id])
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "secret"
      end
    end
end


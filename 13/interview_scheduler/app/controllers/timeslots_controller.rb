class TimeslotsController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required
  # GET /timeslots
  # GET /timeslots.xml
  def index
    conditions = nil
    unless current_user.has_role?('interviewer')
      conditions = ['interviewee_id IS NULL OR interviewee_id = ?',
                     current_user.id]
    end
    @timeslots = Timeslot.find(:all,
                                :conditions=>conditions,
                                :order=>'interview_at asc, position')
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @timeslots }
    end 
  end
  # GET /timeslots/new
  # GET /timeslots/new.xml
  def new
    permit 'interviewer' do
       @timeslot = Timeslot.new
       respond_to do |format|
         format.html # new.html.erb
         format.xml { render :xml => @timeslot }
       end
    end
  end
  # GET /timeslots/1/edit
  def edit
    permit 'interviewer' do
       @timeslot = Timeslot.find(params[:id])
   end
  end
  # POST /timeslots/1/schedule
  def schedule
    permit 'interviewee' do
       @timeslot = Timeslot.find(params[:id])
       @timeslot.interviewee = current_user
       respond_to do |format|
         if @timeslot.save
           flash[:notice] = 'Interview was successfully scheduled!'
           format.html { redirect_to(timeslots_path) }
           format.xml { render :xml => @timeslot, :status => :created,
                                :location => @timeslot }
         else
           format.html { render :action => "new" }
           format.xml { render :xml => @timeslot.errors,
                                :status => :unprocessable_entity }
         end
       end
    end
  end
  # POST /timeslots
  # POST /timeslots.xml
  def create
    permit 'interviewer' do
       @timeslot = Timeslot.new(params[:timeslot])
      respond_to do |format|
        if @timeslot.save
          flash[:notice] = 'Timeslot was successfully created.'
          format.html { redirect_to(timeslots_path) }
          format.xml { render :xml => @timeslot, :status => :created,
                               :location => @timeslot }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @timeslot.errors,
                               :status => :unprocessable_entity }
        end
      end
    end
  end
  # PUT /timeslots/1
  # PUT /timeslots/1.xml
  def update
    permit 'interviewer' do
      @timeslot = Timeslot.find(params[:id])
      respond_to do |format|
        if @timeslot.update_attributes(params[:timeslot])
          flash[:notice] = 'Timeslot was successfully updated.'
          format.html { redirect_to(timeslots_path) }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml { render :xml => @timeslot.errors,
                               :status => :unprocessable_entity }
        end
      end
    end
  end
  # DELETE /timeslots/1
  # DELETE /timeslots/1.xml
  def destroy
    permit 'interviewer' do
      @timeslot = Timeslot.find(params[:id])
      @timeslot.destroy
      respond_to do |format|
        format.html { redirect_to(timeslots_path) }
        format.xml { head :ok }
      end
    end
  end
end


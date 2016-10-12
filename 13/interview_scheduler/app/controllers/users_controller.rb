class UsersController < ApplicationController
  include AuthenticatedSystem
  # render new.rhtml
  def new
  end
  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.save
    @user.has_role('interviewee')
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end
end


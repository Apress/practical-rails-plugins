class WishesController < ApplicationController
  before_filter :get_user
  before_filter :ownership_required, :only => [:new, :create, :destroy]

  def index
    @wishes = @user.wishes.find(:all, :order => "created_at")
  end

  def new
    @wish = @user.wishes.build
  end

  def create
    @wish = @user.wishes.build(params[:wish])

    if @wish.save
      flash[:notice] = "Your wish was successfully created."
      redirect_to(user_wishes_url(@user))
    else
      render(:action => "new")
    end
  end

  def destroy
    @wish = @user.wishes.find(params[:id])
    @wish.destroy
    flash[:notice] = "Your wish was removed from the list."
    redirect_to(user_wishes_url(@user))
  end

  protected

  def get_user
    @user = User.find(params[:user_id])
  end

  def ownership_required
    (logged_in? && @user == current_user) || access_denied
  end
end


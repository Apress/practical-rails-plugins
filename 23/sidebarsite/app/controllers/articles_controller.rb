class ArticlesController < ApplicationController
  sidebar :login, :unless => :logged_in?
  sidebar :music, :component => { :controller => 'sidebars', :action => 'music' }
  sidebar :blogs, :only => :index

  def index; end
  def show; end

  protected

  def logged_in?
    !params[:logged_in].nil?
  end
end

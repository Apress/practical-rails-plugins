class ProfilesController < ApplicationController
  before_filter :get_user
  def index
    if @user
      render :action=>'show'
    else
       @users = User.find(:all)
       render :action=>'index'
    end
  end
  def edit
   if @user
      if authorize(@user)
         if request.post?
            if @user.update_attributes(params[:user])
               flash[:notice] = "Profile saved; " <<
                                         "you can view your profile at " <<
                                         "<a href='#{@user.profile_url}'>" <<
                                         "<%=@user.profile_url%></a>"
            else
               flash[:notice] = "Profile not saved."
            end
           end
       else
         render :text=>"Not authorized."
       end
      else
        render :text=>"Profile not found!"
    end
  end
  protected
  def get_user
    @user = User.find_by_username(request.subdomains.first)
  end
  def authorize(user)
    authenticate_or_request_with_http_basic("Profile") do |username, password|
      username == user.username && password == user.password
    end
  end
end


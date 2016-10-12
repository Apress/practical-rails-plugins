class SessionsController < ApplicationController
  OPEN_ID_REQUIRED = [:nickname, :email]
  OPEN_ID_OPTIONAL = [] # [:fullname]

  # render new.rhtml
  def new
  end

  def create
    if using_open_id?
      open_id_authentication(params[:openid_url])
    else
      password_authentication(params[:login], params[:password])
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  protected

    def password_authentication(login, password)
      if self.current_user = User.authenticate(login, password)
        successful_login
      else
        failed_login("Incorrect username or password")
      end
    end

    def open_id_authentication(openid_url)
      authenticate_with_open_id(openid_url, 
          :required => OPEN_ID_REQUIRED, 
          :optional => OPEN_ID_OPTIONAL.empty? ? nil : OPEN_ID_OPTIONAL) do |result, openid_url, registration|
        if result.successful?
          # look up the user by their openid_url attribute; if not found, create a new account
          if openid_user = User.find_or_create_by_openid_url(openid_url)
            # use OpenID profile information to obtain required fields
            assign_registration_attributes!(openid_user, registration)
            if openid_user.save
              # if successful, log the user in
              self.current_user = openid_user
              successful_login
            else
              failed_login("Profile registration failed: #{openid_user.errors.full_messages.to_sentence}")
            end
          else
            failed_login("Sorry, no user with that OpenID URL exists in our system")
          end
        else
          failed_login(result.message)
        end
      end
    end

    # map OpenID sreg fields to the fields in our user model
    def assign_registration_attributes!(openid_user, registration)
      model_to_registration_mapping.each do |model_attribute, registration_attribute|
        unless registration[registration_attribute].blank?
          openid_user.send("#{model_attribute}=", registration[registration_attribute])
        end
      end
    end

    def model_to_registration_mapping
      { :login => 'nickname', :email => 'email' }
    end

  private

    def successful_login
      flash[:message] = "Logged in successfully"
      redirect_to(root_url)
    end

    def failed_login(message)
      flash[:error] = message
      redirect_to(new_session_url)
    end
end


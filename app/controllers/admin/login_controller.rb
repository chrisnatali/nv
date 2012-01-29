class Admin::LoginController < ApplicationController

  layout "login"

  def index
    if request.get?
      session[:user_id] = nil
      @user = User.new
    else
      @user = User.new(params[:user])
      logged_in_user = @user.try_to_login
      if logged_in_user
        session[:user_id] = logged_in_user.id

        #always logging into "admin" section of site
        redirect_to(:controller => "summary", :action => "index")
      else
        @error = "Error"
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "index")
  end

end

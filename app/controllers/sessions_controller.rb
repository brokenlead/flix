class SessionsController < ApplicationController
    def new
        # display form only, see view
    end
    def create
        if user = User.authenticate(params[:login], params[:password])
            session[:user_id] = user.id
            flash[:notice] = "Welcome back, #{user.name}!"
            redirect_to(session[:intended_url] || user)
            session[:intended_url] = nil
        else
            flash.now[:alert] = "Invalid login info"
            render :new
        end
    end
    def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "You have successfully signed out"
    end
end

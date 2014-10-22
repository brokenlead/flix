class SessionsController < ApplicationController
    def new
        
    end
    def create
        if user = User.authenticate(params[:login], params[:password])
            session[:user_id] = user.id
            flash[:notice] = "Welcome back, #{user.name}!"
            redirect_to user
        else
            flash.now[:alert] = "Invalid"
            render :new
        end
    end
end

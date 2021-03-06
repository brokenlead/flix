class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update]
    before_action :require_admin, only: [:destroy]
    before_action :set_username, only: [:show, :edit, :destroy]

    def index
        @users = User.not_admins
    end
    def show
        @reviews = @user.reviews
        @favorite_movies = @user.favorite_movies
    end
    def new
        @user = User.new
    end
    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "Account was successfully created!"
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @user.update(user_params)
            redirect_to user_path(@user)
        else
            render :edit
        end
    end
    def destroy
        @user.destroy
        session[:user_id] = nil
        redirect_to root_url, alert: "Account was successfully deleted"
    end

private

    def require_correct_user
        @user = User.find_by(username: params[:id])
        redirect_to root_url unless current_user?(@user)
    end
    def user_params
        params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
    end
    def set_username
        @user = User.find_by(username: params[:id])
    end
end

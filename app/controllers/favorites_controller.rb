class FavoritesController < ApplicationController
    before_action :require_signin
    before_action :set_movie

    def create
        @movie.favorites.create!(user: current_user)
        redirect_to @movie, notice: "Saved your favorite!"
    end

    def destroy
        current_user.favorites.find_by(movie: @movie).destroy
        redirect_to @movie, notice: "Saved your changes"
    end

    private

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end
end

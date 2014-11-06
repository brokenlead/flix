class GenresController < ApplicationController
    before_action :require_signin
    before_action :require_admin, except: [:show]

    def index
        @genres = Genre.all
    end

    def new
        @genre = Genre.new
    end

    def create
        @genre = Genre.create(genre_params)
        if @genre.save
            redirect_to genres_path, notice: "Genre successfully created!"
        else
            render :new
        end
    end

    def show
        @genre = Genre.find(params[:id])
        @movies = @genre.movies
    end

    def edit
        @genre = Genre.find(params[:id])
    end

    def update
        @genre = Genre.find(params[:id])
        if @genre.update(genre_params)
            redirect_to genres_path, notice: "Genre successfully updated!"
        else
            render :edit
        end
    end

    def destroy
        @genre = Genre.find(params[:id])
        if @genre.destroy
            redirect_to genres_path, alert: "Genre deleted!"
        else
            render :edit
        end
    end

    private

    def set_genre
        @genre = Genre.find(params[:id])
    end

    def genre_params
        params.require(:genre).permit(:name)
    end
end

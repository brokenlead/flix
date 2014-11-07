require "spec_helper"

describe "Viewing a user" do

    it "shows the user information" do
        user = User.create!(user_attributes)
        sign_in(user)
        visit user_url(user)
        expect(page).to have_text(user.name)
        expect(page).to have_text(user.email)
        expect(page).to have_text("Member since")
    end

    it "shows the user's favorite movies in the sidebar" do
        user = User.create!(user_attributes)
        movie = Movie.create!(movie_attributes)
        user.favorite_movies << movie
        sign_in(user)
        visit user_url(user)
        within("aside#sidebar") do
            expect(page).to have_text(movie.title)
        end
    end

    it "shows the user's name in the title" do
        user = User.create!(user_attributes)
        sign_in(user)
        visit user_url(user)
        expect(page).to have_title("Flix - #{user.name}")
    end

end
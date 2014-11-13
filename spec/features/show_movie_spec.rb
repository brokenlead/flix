require 'spec_helper'

describe "Viewing an individual movie" do

  before do
      @user = User.create!(user_attributes)
      sign_in(@user)
  end

  it "shows the movie's details" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
    expect(page).to have_text(movie.cast)
    expect(page).to have_text(movie.director)
    expect(page).to have_text(movie.duration)
  end  
  
  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create(movie_attributes(total_gross: 60000000))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 40000000))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end

  it "shows the movie's fans and genres in the sidebar" do
    movie = Movie.create!(movie_attributes)
    movie.fans << @user
    genre = Genre.create!(name: 'Action')
    movie.genres << genre
    visit movie_url(movie)
    within('aside#sidebar') do
      expect(page).to have_text(@user.name)
      expect(page).to have_text(genre.name)
    end
  end

  it "shows a properly formatted page title" do
    movie = Movie.create!(movie_attributes)
    visit movie_url(movie)
    expect(page).to have_title("Flix - #{movie.title}")
  end

  it "has a SEO-friendly url" do
    movie = Movie.create!(movie_attributes(title: "X Men"))
    visit movie_url(movie)
    expect(current_path).to eq("/movies/x-men")
  end
end
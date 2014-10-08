module MoviesHelper
  def format_total_gross(movie)
    if movie.flop?
      content_tag(:strong, 'Flop!')
    else
     number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image.exists?
     image_tag(movie.image.url(:small))
    else
     image_tag('placeholder.png')
    end
  end

  def format_average_stars_for(movie)
    if movie.reviews.count > 0
      link_to("Read #{pluralize(movie.reviews.count, 'Review')}", movie_reviews_path(movie)) +
      " (Average " +
        stars_average_for(movie) +
        ")"
    else
      link_to "No Reviews", movie_reviews_path(movie)
    end
  end

  def stars_average_for(movie)
    content_tag(:strong, pluralize(number_with_precision(movie.average, precision: 1), "star"))
  end
end

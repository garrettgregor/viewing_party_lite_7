# frozen_string_literal: true

class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :minutes,
              :runtime,
              :genres,
              :summary,
              :poster_path

  def initialize(details)
    @id = details[:id]
    @title = details[:title]
    @vote_average = details[:vote_average]
    @minutes = details[:runtime]
    @runtime = @minutes.nil? ? 0 : time_conversion(@minutes)
    @genres = details[:genres].nil? ? nil : get_genres(details[:genres])
    @summary = details[:overview]
    @poster_path = details[:poster_path]
  end

  def get_genres(genres_details)
    genres_details.map { |genre| genre[:name] }
  end

  def time_conversion(time)
    hours = time / 60
    minutes = time % 60
    "#{hours}hr #{minutes}min"
  end
end

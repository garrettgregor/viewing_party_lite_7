# frozen_string_literal: true

class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :minutes,
              :runtime,
              :genres,
              :summary

  def initialize(details)
    @id = details[:id]
    @title = details[:title]
    @vote_average = details[:vote_average]
    @minutes = details[:runtime]
    @runtime = time_conversion(@minutes)
    @genres = get_genres(details[:genres])
    @summary = details[:overview]
  end

  def get_genres(genres_details)
    genres_details.map { |genre| genre[:name] }
  end

  def time_conversion(time)
    hours = time / 60
    minutes = time % 60
    formatted = "#{hours}hr #{minutes}min"
  end
end

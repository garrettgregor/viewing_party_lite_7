# frozen_string_literal: true

class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :minutes,
              :genres,
              :summary,
              :cast,
              :review_count,
              :authors_info

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @minutes = attributes[:minutes]
    @genres = attributes[:genre_ids]
    @summary = attributes[:overview]
    @cast = attributes[:cast]
    @review_count = attributes[:review_count]
    @authors_info = attributes[:authors_info]
  end
end

class Movie
  attr_reader :title,
              :vote_average

  def initialize(attributes)
    @title        = attributes[:title]
    @vote_average = attributes[:vote_average]
  end
end
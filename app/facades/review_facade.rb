class ReviewFacade
  def initialize(search)
    @search = search
  end

  def movie_review_show
    service = MovieService.new
    review = service.movie_reviews(@search)
    @review = Review.new(review)
  end
end
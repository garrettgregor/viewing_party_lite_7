class CreditFacade
  def initialize(search)
    @search = search
  end

  def movie_credits_show
    service = MovieService.new
    credits = service.movie_credits(@search)
    @credits = Credit.new(credits)
  end
end
# frozen_string_literal: true

class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :minutes,
              :runtime,
              :genres,
              :summary,
              # :cast,
              :review_count,
              :review_info

  def initialize(details=nil, reviews=nil)
    @id = details[:id]
    @title = details[:title]
    @vote_average = details[:vote_average]
    @minutes = details[:runtime]
    @runtime = if @minutes == nil then nil else time_conversion(@minutes) end
    @genres = if details == nil then nil else get_genres(details[:genres]) end
    @summary = details[:overview]
    # @cast = if credits == nil then nil else get_credits(credits[:cast]) end
    @review_count = if reviews == nil then nil else reviews[:total_results] end
    @review_info = if reviews == nil then nil else get_review_info(reviews[:results]) end
  end

  def get_genres(genres_details=nil)
    if genres_details == nil
      nil
    else
      genres_details.map { |genre| genre[:name] }
    end
  end

  # def get_credits(credits_details=nil)
  #   if credits_details == nil
  #     nil
  #   else
  #     cast_list = credits_details.map { |person| [person[:name], person[:character]] }
  #     cast_list.slice(0, 10)
  #   end
  # end

  def get_review_info(review_details=nil)
    if review_details == nil
      nil
    else
      review_details.map { |review| { review[:author] => review[:content]} }
    end
  end

  def time_conversion(time)
    hours = time / 60
    minutes = time % 60
    formatted = "#{hours}hr #{minutes}min"
  end
end

# frozen_string_literal: true

class Review
  attr_reader :id,
              :review_count,
              :review_info

  def initialize(reviews)
    @id = reviews[:id]
    @review_count = reviews[:total_results]
    @review_info = get_review_info(reviews[:results])
  end

  def get_review_info(review_details)
    review_details.map { |review| { review[:author] => review[:content] } }
  end
end

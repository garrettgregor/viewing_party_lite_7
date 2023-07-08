# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review do
  it 'exists' do
    attrs = {
      id: 1,
      total_results: 50,
      results: [{ author: 'buzz',
                  content: 'Such a good movie!' }]
    }

    review = Review.new(attrs)

    expect(review).to be_a Review
    expect(review.id).to eq(1)
    expect(review.review_count).to eq(50)
    expect(review.review_info).to be_an(Array)
    expect(review.review_info.first[0]).to eq('buzz')
    expect(review.review_info.first[1]).to eq('Such a good movie!')
  end
end

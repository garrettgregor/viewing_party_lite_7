require 'rails_helper'

describe MovieService do
  context "class methods" do
    context "#members_by_state" do
      it "returns member data", :vcr do
        search = MovieService.new.top_rated
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        movie_search_data = search[:results].first

        expect(movie_search_data).to have_key :title
        expect(movie_search_data[:title]).to be_a(String)

        expect(movie_search_data).to have_key :vote_average
        expect(movie_search_data[:vote_average]).to be_an(Integer)
      end
    end
  end
end
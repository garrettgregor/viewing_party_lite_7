require 'rails_helper'

describe MovieService do
  context 'class methods' do
    context '#top_rated_movies' do
      it 'returns the top rated movies', :vcr do
        search = MovieService.new.top_rated_movies
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        movie_data = search[:results].first

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)
 
        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context '#movie_by_search' do
      it 'returns a movie based on search params', :vcr do
        search = MovieService.new.movie_by_search('Fight Club')
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        movie_data = search[:results].first

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)
 
        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context '#movie_details' do
      it 'returns the movie details by id', :vcr do
        movie_data = MovieService.new.movie_details(238)
        expect(movie_data).to be_a Hash

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)
  
        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)

        expect(movie_data).to have_key(:runtime)
        expect(movie_data[:runtime]).to be_an(Integer)
  
        expect(movie_data).to have_key(:genres)
        expect(movie_data[:genres]).to be_an(Array)
  
        expect(movie_data).to have_key(:overview)
        expect(movie_data[:overview]).to be_a(String)
  
        expect(movie_data).to have_key(:poster_path)
        expect(movie_data[:poster_path]).to be_a(String)
      end
    end 
    
    context '#movie_credits' do
      it 'returns a movie credits', :vcr do
        search = MovieService.new.movie_credits(238)
        expect(search).to be_a Hash
        expect(search[:cast]).to be_an Array
        movie_data = search[:cast].first

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:name)
        expect(movie_data[:name]).to be_a(String)

        expect(movie_data).to have_key(:character)
        expect(movie_data[:character]).to be_a(String)
      end
    end

    context '#movie_reviews' do
      it 'returns the review details by movie id', :vcr do
        movie_data = MovieService.new.movie_reviews(238)
        expect(movie_data).to be_a Hash

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:total_results)
        expect(movie_data[:total_results]).to be_an(Integer)

        expect(movie_data).to have_key(:results)
        
        review_data = movie_data[:results]
        expect(review_data).to be_an(Array)

        expect(review_data.first[:author]).to be_a(String)
        expect(review_data.first[:content]).to be_a(String)
      end
    end 
  end
end
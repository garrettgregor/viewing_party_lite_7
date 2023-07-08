# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    attrs = {
      id: 238,
      title: 'The Godfather',
      genres: [
        {
          id: 18,
          name: 'Drama'
        },
        {
          id: 80,
          name: 'Crime'
        }
      ],
      runtime: 175,
      poster_path: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
      overview: 'Spanning the years 1945 to 1955, a chronicle of the fictional...',
      vote_average: 8.71
    }

    summary = 'Spanning the years 1945 to 1955, a chronicle of the fictional...'

    movie = Movie.new(attrs)

    expect(movie).to be_a Movie
    expect(movie.id).to eq(238)
    expect(movie.title).to eq('The Godfather')
    expect(movie.genres).to eq(%w[Drama Crime])
    expect(movie.runtime).to eq('2hr 55min')
    expect(movie.minutes).to eq(175)
    expect(movie.poster_path).to eq('/3bhkrj58Vtu7enYsRolD1fZdja1.jpg')
    expect(movie.summary).to eq(summary)
    expect(movie.vote_average).to eq(8.71)
  end
end

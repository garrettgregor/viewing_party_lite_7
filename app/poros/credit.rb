# frozen_string_literal: true

class Credit
  attr_reader :id,
              :cast

  def initialize(credits)
    @id = credits[:id]
    @cast = get_credits(credits[:cast])
  end

  def get_credits(credits_details)
    cast_list = credits_details.map { |person| [person[:name], person[:character]] }
    cast_list.slice(0, 10)
  end
end
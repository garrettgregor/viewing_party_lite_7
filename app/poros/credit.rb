# frozen_string_literal: true

class Credit
  attr_reader :id,
              :cast

  def initialize(credits=nil)
    @id = credits[:id]
    @cast = if credits == nil then nil else get_credits(credits[:cast]) end
  end

  def get_credits(credits_details=nil)
    cast_list = credits_details.map { |person| [person[:name], person[:character]] }
    cast_list.slice(0, 10)
  end
end
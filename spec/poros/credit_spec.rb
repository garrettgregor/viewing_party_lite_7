require 'rails_helper'

RSpec.describe Credit do
  it "exists" do
    attrs = {
      id: 1,
      cast: [{name: 'buzz',
              character: 'lightyear'
            }]
    }

    credit = Credit.new(attrs)

    expect(credit).to be_a Credit
    expect(credit.id).to eq(1)
    expect(credit.cast).to be_an(Array)
    expect(credit.cast.first[0]).to eq('buzz')
    expect(credit.cast.first[1]).to eq('lightyear')
  end
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  it 'is valid with valid attributes' do
    expect(Match.new(user_id: 1, matched_id: 2, prospects_ids: [2, 4])).to be_valid
  end
end

RSpec.describe Match, type: :model do
  before(:all) do
    @match = Match.create(user_id: 1, matched_id: 2, prospects_ids: [2, 4])
  end

  it 'checks that a match can be created' do
    expect(@match).to be_valid
  end

  it 'checks that a match can be read' do
    expect(Match.last).to eq(@match)
  end

  it 'checks that a match can be destroyed' do
    previous_match_count = Match.count
    @match.destroy
    expect(Match.count).to be < previous_match_count
  end
end

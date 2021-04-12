# frozen_string_literal: true

require 'rails_helper'

# Profile Model Unit Test
RSpec.describe Profile, type: :model do
  subject do
    described_class.new(
      email: 'blah@gmail.com',
      name: 'Billy Joe',
      user_id: 21
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an user_id' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
end

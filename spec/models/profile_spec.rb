# frozen_string_literal: true

require 'rails_helper'

# Profile Model Unit Test
RSpec.describe Profile, type: :model do
  before(:each) do
    @user = User.create(id: 1, email: 'c@gmail.com', name: 'User Name' password: '12345', email_confirmation_token: 'token', email_confirmed_at: nil)
    @subject = Profile.create(id: 1, user_id: @user.id, name: 'User 1', email: 'u1@gmail.com')
  end

  it 'is valid with valid attributes' do
    expect(@subject).to be_valid
  end

  it 'is not valid without an email' do
    @subject.email = nil
    expect(@subject).to_not be_valid
  end

  it 'is not valid without an name' do
    @subject.name = nil
    expect(@subject).to_not be_valid
  end

  it 'is not valid without an user_id' do
    @subject.user_id = nil
    expect(@subject).to_not be_valid
  end

  it 'has empty about me when one is not provided' do
    expect(@subject.aboutme).to_not be_nil
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

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

RSpec.describe "Controller Test", type: :system do
    describe "proper messages" do
        it "should flash correct messages in index2" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "a@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "a"
            click_button "Create Profile"
            expect(page).to have_content("Profile created successfully.")
        end

        it "Must have a name" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "b@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            click_button "Create Profile"
            expect(page).to have_content("Profile must have a name.")
        end
    end
end

#User Requirements Testing
RSpec.describe "User Working on profile", type: :system do
    it "Create a profile" do
        visit new_profile_path
        click_link "Sign up"
        fill_in "user[email]", with: "c@gmail.com"
        fill_in "Password", with: "12345"
        click_button "Sign up"
        visit new_profile_path
        fill_in "Name", with: "Bob"
        click_button "Create Profile"
        expect(page).to have_content("Bob")
    end

    it "Edit a profile" do
      visit profiles_path
      click_link "Sign up"
      fill_in "user[email]", with: "d@gmail.com"
      fill_in "Password", with: "12345"
      click_button "Sign up"
      visit new_profile_path
      fill_in "Name", with: "Bob"
      click_button "Create Profile"
      visit edit_profile_path(Profile.last)
      fill_in "Name", with: "Joe"
      click_button "Save Profile"
      expect(page).to have_content("Joe")
    end

    it "Show a profile" do
      visit profiles_path
      click_link "Sign up"
      fill_in "user[email]", with: "e@gmail.com"
      fill_in "Password", with: "12345"
      click_button "Sign up"
      visit new_profile_path
      fill_in "Name", with: "e"
      click_button "Create Profile"
      visit show_profile_path(Profile.last)
      expect(page).to have_content(Profile.last)
    end

    it "Delete a profile" do
      visit profiles_path
      click_link "Sign up"
      fill_in "user[email]", with: "f@gmail.com"
      fill_in "Password", with: "12345"
      click_button "Sign up"
      visit new_profile_path
      fill_in "Name", with: "f"
      click_button "Create Profile"
      visit delete_profile_path(Profile.last)
      click_button "Delete Profile"
      expect(page).to have_content("Profile successfully deleted")
    end
end

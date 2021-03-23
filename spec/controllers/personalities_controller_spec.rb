# frozen_string_literal: true

require 'rails_helper'

#Integration Testing
RSpec.describe "Controller Test", type: :system do
    describe "Should reject user if personlities tests are not filled out" do
        it "Reject if try to click on Myers Briggs page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "The Avoidant Turtle", from: "profile[ptanimal]"
            select "Green", from: "profile[pttruecolors]"
            select "Reformer", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("Profile must have MB test filled out to view this page.")
        end

        it "Reject if try to click on Conflict Management page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "INFP", from: "profile[ptmyersbriggs]"
            select "Gold", from: "profile[pttruecolors]"
            select "Individualist", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("Profile must have result of Conflict Management test filled out to view this page.")
        end

        it "Reject if try to click on True Colors page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "ENFJ", from: "profile[ptmyersbriggs]"
            select "The Collaborative Owl", from: "profile[ptanimal]"
            select "Enthusiast", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Profile must have result of True Colors test filled out to view this page.")
        end

        it "Reject if try to click on Enneagram page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "ENTJ", from: "profile[ptmyersbriggs]"
            select "Blue", from: "profile[pttruecolors]"
            select "The Competitive Shark", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Profile must have result of Enneagram test filled out to view this page.")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for Myers Briggs
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results MB" do
        it "Show user their own personality type INFP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "INFP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("Your Personality Type: INFP")
        end
        it "Show user a match ENFP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ENFP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INFP")
        end
        it "Show user a match INFJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g1@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "INFJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ENFP")
        end
        it "Show user a match ENFJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h1@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ENFJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INFJ")
        end
        it "Show user a match INTJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g2@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "INTJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ENFJ")
        end
        it "Show user a match ENTJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h2@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ENTJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INTJ")
        end
        it "Show user a match INTP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g3@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "INTP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ENTJ")
        end
        it "Show user a match ENTP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h3@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ENTP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INTP")
        end
        it "Show user a match ISFP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g4@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "ISFP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ENFJ")
        end
        it "Show user a match ESFP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h4@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ESFP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INTJ")
        end
        it "Show user a match ISTP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g5@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "ISTP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INTJ")
        end
        it "Show user a match ESTP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h5@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ESTP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("INTJ")
        end
        it "Show user a match ISFJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g6@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "ISFJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ESFP")
        end
        it "Show user a match ESFJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h6@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ESFJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ISFP")
        end
        it "Show user a match ISTJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g7@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "ISTJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ESFP")
        end
        it "Show user a match ESTJ" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h7@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "ESTJ", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("ISFP")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for Conflict Management
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results Conflict Management" do
        it "Show user their own personality type Shark" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Competitive Shark", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As a Shark, your best matches are teddy bears!")
        end
        it "Show user a match Fox" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h1@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Compromising Fox", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("The Competitive Shark")
        end
        it "Show user a match Teddy Bear" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h2@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Accommodating Teddy Bear", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("The Competitive Shark")
        end
        it "Show user their own personality type Owl" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h3@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Collaborative Owl", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As an Owl, your best matches are turtles!")
        end
        it "Show user a match Turtle" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h4@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Avoidant Turtle", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("The Collaborative Owl")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for True Colors
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results True Colors" do
        it "Show user their own personality type Gold" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Gold", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Users who have the same color as you (Gold):")
        end
        it "Show user their own personality type Blue" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Blue", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Users who have the same color as you (Blue):")
        end
        it "Show user their own personality type Green" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Green", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Users who have the same color as you (Green):")
        end
        it "Show user their own personality type Orange" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Orange", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Users who have the same color as you (Orange):")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for Enneagram
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results Enneagram" do
        it "Show user their own personality type Reformer" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Reformer", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Invidualists and Enthusiasts!")
        end
        it "Show user their own personality type Helper" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Helper", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Invidualists and Challengers")
        end
        it "Show user their own personality type Achiever" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Achiever", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Loyalists and Peacemakers!")
        end
        it "Show user their own personality type Individualist" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Individualist", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Reformers and Helpers!")
        end
        it "Show user their own personality type Investigator" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Investigator", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Enthusiasts and Challengers!")
        end
        it "Show user their own personality type Loyalist" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Loyalist", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Achievers and Peacemakers!")
        end
        it "Show user their own personality type Enthusiast" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Enthusiast", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Reformers and Investigators!")
        end
        it "Show user their own personality type Challenger" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Challenger", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Helpers and Investigators!")
        end
        it "Show user their own personality type Peacemaker" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Peacemaker", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Acheivers and Loyalists!")
        end
    end
end
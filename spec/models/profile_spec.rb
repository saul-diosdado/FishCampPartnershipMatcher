require "rails_helper"

#Profile Model Unit Test
RSpec.describe Profile, type: :model do
    subject {
        described_class.new(
            email: "blah@gmail.com",
            name: "Billy Joe",
            user_id: 21
        )
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without an email" do
        subject.email = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without an name" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without an user_id" do
        subject.user_id = nil
        expect(subject).to_not be_valid
    end
end

#Integration Testing
# RSpec.describe "Controller Test", type: :system do
#     describe "proper messages" do
#         it "should flash correct messages in index2" do 
#             visit new_profile_path
#             fill_in "Name", with: "Bob"
#             click_button "Create Profile"
#             expect(page).to have_content("Profile created successfully.")
#         end

#         it "Must have a name" do
#             visit new_profile_path
#             click_button "Create Profile"
#             expect(page).to have_content("Profile must have a name.")
#         end
#     end
# end

# #User Requirements Testing
# RSpec.describe "Create a profile", type: :system do
#     it "Create a profile" do
#         visit new_profile_path
#             fill_in "Name", with: "Bob"
#             click_button "Create Profile"
#             expect(page).to have_content("Bob")
#     end
#     it "Edit a profile" do
#         visit edit_profile_path
#         fill_in "Name", with: "Joe"
#         click_button "Edit Profile"
#         expect(page).to have_content("Joe")
#     end
# end
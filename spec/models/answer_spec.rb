
require 'rails_helper'

# Answer Model Unit Test
RSpec.describe Answer, type: :model do
  # Testing short answer
  it 'short answer is valid with valid attributes' do
    expect(Answer.new(user_id: 1, question_id: 1, preference_form_id: 1, answer_type: "Short Answer", short_answer: "Test")).to be_valid
  end

  # Testing true/false answer
  it 'true_false is valid with valid attributes' do
    expect(Answer.new(user_id: 2, question_id: 2, preference_form_id: 2, answer_type: "True/False", true_false: TRUE)).to be_valid
  end

  # Testing numeric answer
  it 'numeric is valid with valid attributes' do
    expect(Answer.new(user_id: 3, question_id: 3, preference_form_id: 3, answer_type: "Numeric", numeric: 1)).to be_valid
  end

  # Testing multiple choice answer
  it 'multiple choice valid with valid attributes' do
    expect(Answer.new(user_id: 4, question_id: 4, preference_form_id: 4, answer_type: "Multiple Choice", multiple_choice: "Test")).to be_valid
  end

  # Validating presence of user ID
  it 'is not valid because user_id is blank or not present' do
    expect(Answer.new(question_id: 1, preference_form_id: 1, answer_type: "Short Answer", short_answer: "Test")).to be_invalid
  end

  # Validating presence of question ID
  it 'is not valid because question_id is blank or not present' do
    expect(Answer.new(user_id: 1, preference_form_id: 1, answer_type: "Short Answer", short_answer: "Test")).to be_invalid
  end
  
  # Validating presence of form ID
  it 'is not valid because preference_form_id is blank or not present' do
    expect(Answer.new(user_id: 1, question_id: 1, answer_type: "Short Answer", short_answer: "Test")).to be_invalid
  end
  
  # Validating presence of answer type
  it 'is not valid because answer_type is blank or not present' do
    expect(Answer.new(user_id: 1, question_id: 1, preference_form_id: 1, short_answer: "Test")).to be_invalid
  end
end

# Checks that answers can be created, read, and deleted.
RSpec.describe Answer, type: :model do
  before(:all) do
    @answer = Answer.create(user_id: 1, question_id: 1, preference_form_id: 1, answer_type: "Short Answer", short_answer: "Test")
  end

  it 'checks that a answer can be created' do
    expect(@answer).to be_valid
  end

  it 'checks that a answer can be read' do
    expect(Answer.last).to eq(@answer)
  end

  it 'checks that a answer can be destroyed' do
    previous_answer_count = Answer.count
    @answer.destroy
    expect(Answer.count).to be < previous_answer_count
  end
end

# Integration Testing Controller Flash Notice
RSpec.describe 'Controller Test', type: :system do
  describe 'proper messages' do
    it 'should flash correct message in index' do
      visit new_profile_path
      click_link "Sign up"
      fill_in "user[email]", with: "g@gmail.com"
      fill_in "Password", with: "12345"
      click_button "Sign up"

      visit preference_forms_path
      click_link "Create New Form"
      fill_in 'preference_form_title', with: 'test form'
      select 'Public', from: 'preference_form[active]'
      click_button "Add Question"

      click_link 'Create New Question'
      fill_in 'question[question]', with: 'q1'
      click_button 'Submit'

      visit public_forms_path
      click_link 'Open'
      click_link 'Add Response'
      fill_in 'answer[short_answer]', with: 'A1'
      click_button 'Save Response'
      expect(page).to have_content('Response Saved.')

      click_link 'Edit'
      fill_in 'answer[short_answer]', with: 'A2'
      click_button 'Save Response'
      expect(page).to have_content('Response Updated.')

      click_link 'Delete Response'
      click_button 'Delete Response'
      expect(page).to have_content('Response Deleted.')
    end
  end
end

# Acceptance Test User Requirement
RSpec.describe 'User actions', type: :system do
  it 'create, edit, and delete answers' do
    visit new_profile_path
    click_link "Sign up"
    fill_in "user[email]", with: "g@gmail.com"
    fill_in "Password", with: "12345"
    click_button "Sign up"

    visit preference_forms_path
    click_link "Create New Form"
    fill_in 'preference_form_title', with: 'test form'
    select 'Public', from: 'preference_form[active]'
    click_button "Add Question"

    click_link 'Create New Question'
    fill_in 'question[question]', with: 'q1'
    click_button 'Submit'

    visit public_forms_path
    click_link 'Open'
    click_link 'Add Response'
    fill_in 'answer[short_answer]', with: 'A1'
    click_button 'Save Response'
    expect(page).to have_content('A1')

    click_link 'Edit'
    fill_in 'answer[short_answer]', with: 'A2'
    click_button 'Save Response'
    expect(page).to have_content('A2')

    click_link 'Delete Response'
    click_button 'Delete Response'
    expect(page).to have_no_content('A2')
  end
end

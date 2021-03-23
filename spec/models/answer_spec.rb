
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

  it 'checks that a question can be read' do
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
      visit new_question_path
      fill_in 'Question', with: 'Is this a question?'
      click_button 'Submit'
      expect(page).to have_content('Question created successfully.')
    end

    it "can't be blank" do
      visit new_question_path
      select 'True/False', from: 'Question type'
      click_button 'Submit'
      expect(page).to have_content("Question can't be blank")
    end
  end
end

# Acceptance Test User Requirement
RSpec.describe 'Questionnaire director', type: :system do
  it 'creates short answer question' do
    visit new_question_path
    fill_in 'Question', with: 'Example question 1?'
    select 'Short Answer', from: 'Question type'
    click_button 'Submit'
    expect(page).to have_content('Question created successfully.')
  end

  it 'creates numeric question' do
    visit new_question_path
    fill_in 'Question', with: 'Example question 2?'
    select 'Numeric', from: 'Question type'
    click_button 'Submit'
    expect(page).to have_content('Question created successfully.')
  end

  it 'creates true/false question' do
    visit new_question_path
    fill_in 'Question', with: 'Example question 3?'
    select 'True/False', from: 'Question type'
    click_button 'Submit'
    expect(page).to have_content('Question created successfully.')
  end

  it 'creates multiple choice question' do
    visit new_question_path
    fill_in 'Question', with: 'Example question 4?'
    select 'Multiple Choice', from: 'Question type'
    click_button 'Submit'
    expect(page).to have_content('Question created successfully.')
  end
end

RSpec.describe 'Questionnaire director 2', type: :system do
  it 'edits question' do
    visit edit_question_path(Question.last)
    fill_in 'Question', with: 'Edited this question?'
    click_button 'Update Question'
    expect(page).to have_content('Question updated successfully.')
  end

  it 'show question' do
    visit question_path(Question.last)
    expect(page).to have_content(Question.last.question)
  end

  it 'deletes question' do
    visit delete_question_path(Question.last)
    click_button 'Delete Question'
    expect(page).to have_content('Question removed successfully.')
  end

  it 'makes invalid edit' do
    visit edit_question_path(Question.last)
    fill_in 'Question', with: ''
    click_button 'Update Question'
    expect(page).to have_content("Question can't be blank")
  end
end

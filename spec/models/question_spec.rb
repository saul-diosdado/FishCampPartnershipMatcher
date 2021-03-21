# frozen_string_literal: true

require 'rails_helper'

# Question Model Unit Test
RSpec.describe Question, type: :model do
  it 'is valid with valid attributes' do
    expect(Question.new(question: 'Is this an example of a question?', question_type: 'Short Answer')).to be_valid
  end

  it 'is not valid because question field is blank or not present' do
    expect(Question.new).to be_invalid
  end
end

RSpec.describe Question, type: :model do
  before(:all) do
    @question = Question.create(question: 'Test q?', question_type: 'Short Answer')
  end

  it 'checks that a question can be created' do
    expect(@question).to be_valid
  end

  it 'checks that a question can be read' do
    expect(Question.last).to eq(@question)
  end

  it 'checks that a question can be destroyed' do
    previous_question_count = Question.count
    @question.destroy
    expect(Question.count).to be < previous_question_count
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

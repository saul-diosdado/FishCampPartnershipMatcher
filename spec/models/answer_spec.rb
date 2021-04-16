
require 'rails_helper'

# Answer Model Unit Test
RSpec.describe Answer, type: :model do
  before(:all) do
    @user = User.create(id: 1, name: 'User Name', email: 'c@gmail.com', password: '12345', email_confirmation_token: 'token', email_confirmed_at: nil)
    @q_1 = Question.create(id:1, preference_form_id: 1, question: 'Is this a quesiton?', question_type: 'Short Answer')
    @q_2 = Question.create(id:2, preference_form_id: 1, question: 'Is this a quesiton 2?', question_type: 'Multiple Choice')
    @q_3 = Question.create(id:3, preference_form_id: 1, question: 'Is this a quesiton 3?', question_type: 'True/False')
    @q_4 = Question.create(id:4, preference_form_id: 1, question: 'Is this a quesiton 4?', question_type: 'Numeric')
  end

  # Testing short answer
  it 'short answer is valid with valid attributes' do
    expect(Answer.new(user_id: 1, question_id: 1, preference_form_id: 1, answer_type: "Short Answer", short_answer: "Test")).to be_valid
  end

  # Testing multiple choice answer
  it 'multiple choice valid with valid attributes' do
    expect(Answer.new(user_id: 1, question_id: 2, preference_form_id: 4, answer_type: "Multiple Choice", multiple_choice: "Test")).to be_valid
  end

  # Testing true/false answer
  it 'true_false is valid with valid attributes' do
    expect(Answer.new(user_id: 1, question_id: 3, preference_form_id: 2, answer_type: "True/False", true_false: TRUE)).to be_valid
  end

  # Testing numeric answer
  it 'numeric is valid with valid attributes' do
    expect(Answer.new(user_id: 1, question_id: 4, preference_form_id: 3, answer_type: "Numeric", numeric: 1)).to be_valid
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

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# Checks that answers can be created, read, and deleted.
RSpec.describe Answer, type: :model do
  before(:all) do
    @user = User.create(id: 1, name: 'User name', email: 'c@gmail.com', password: '12345', email_confirmation_token: 'token', email_confirmed_at: nil)
    @form = PreferenceForm.create(title: 'Test', num_prefs: 2, num_antiprefs: 1, active: true)
    @question = Question.create(id: 1, preference_form_id: 1, question: 'Test q?', question_type: 'Short Answer')
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

  it 'checks that an answer is destroyed after the question is destroyed' do
    previous_answer_count = Answer.count
    previous_question_count = Question.count
    @question.destroy
    expect(Answer.count).to be < previous_answer_count
    expect(Question.count).to be < previous_question_count
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

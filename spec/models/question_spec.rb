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

# Question Model Unit Tests
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

  it 'checks that a question can be destroyed and all choices also destroyed' do
    @q_2 = Question.create(id:2, preference_form_id: 1, question: 'Is this a quesiton 2?', question_type: 'Multiple Choice')
    @c_1 = Choice.create(id: 1, content: 'Possibly.', question_id: 2)
    previous_question_count = Question.count
    previous_choice_count = Choice.count
    @q_2.destroy
    expect(Question.count).to be < previous_question_count
    expect(Choice.count).to be < previous_choice_count
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

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


require 'rails_helper'

# PreferenceForm Model Unit Test
RSpec.describe PreferenceForm, type: :model do
  it 'preference form is valid with valid attributes' do
    expect(PreferenceForm.new(title: 'test', num_prefs: 2, num_antiprefs: 1, active: TRUE)).to be_valid
  end
end

# Checks that prefernce form can be created, read, and deleted.
RSpec.describe PreferenceForm, type: :model do
  before(:each) do
    @form = PreferenceForm.create(id: 1, title: 'test', num_prefs: 2, num_antiprefs: 1, active: TRUE)
  end

  it 'checks that a form can be created' do
    expect(@form).to be_valid
  end

  it 'checks that a form can be read' do
    expect(PreferenceForm.last).to eq(@form)
  end

  it 'checks that a form can be destroyed' do
    previous_form_count = PreferenceForm.count
    @form.destroy
    expect(PreferenceForm.count).to be < previous_form_count
  end

  it 'checks that a deleted form also deletes the associated questions' do
    Question.create(id:1, preference_form_id: 1, question: 'Is this a quesiton?', question_type: 'Short Answer')
    Question.create(id:2, preference_form_id: 1, question: 'Is this a quesiton 2?', question_type: 'Multiple Choice')
    Question.create(id:3, preference_form_id: 1, question: 'Is this a quesiton 3?', question_type: 'True/False')
    Question.create(id:4, preference_form_id: 1, question: 'Is this a quesiton 4?', question_type: 'Numeric')

    previous_form_count = PreferenceForm.count
    previous_question_count = Question.count
    @form.destroy
    expect(PreferenceForm.count).to be < previous_form_count
    expect(Question.count).to be < previous_question_count
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

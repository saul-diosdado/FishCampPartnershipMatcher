require "rails_helper"

# Question Model Unit Test
RSpec.describe Question, type: :model do
  it "is valid with valid attributes" do
    expect(Question.new(question: "Is this an example of a question?", question_type: "Short Answer")).to be_valid
  end

  it "is not valid because question field is blank or not present" do
    expect(Question.new).to be_invalid
  end
end

RSpec.describe Question, type: :model do
  before(:all) do
    @question = Question.create(question: "Test q?", question_type: "Short Answer")
  end

  it 'checks that a question can be created' do
    expect(@question).to be_valid
  end

  it 'checks that a question can be read' do
    expect(Question.find_by_question("Test q?")).to eq(@question)
  end

  # it 'checks that a question can be updated' do
  #   @song.update(:question => "Is this a test question?")
  #   expect(Song.find_by_question("Is this a test question?")).to eq(@question)
  # end

  it 'checks that a question can be destroyed' do
    @question.destroy
    expect(Question.count).to eq(0)
  end
end

# Integration Testing Controller Flash Notice
RSpec.describe "Controller Test", type: :system do
  describe "proper messages" do
    it "should flash correct message in index" do
      visit new_question_path
      fill_in "Question", with: "Is this a question?"
      click_button "Submit"
      expect(page).to have_content("Question created successfully.")
    end

    it "can't be blank" do
      visit new_question_path
      select "True/False", :from => "Question type"
      click_button "Submit"
      expect(page).to have_content("Question can't be blank")
    end
  end
end

# Acceptance Test User Requirement
RSpec.describe "Make a questionnaire", type: :system do
  it "create short answer question" do
    visit new_question_path
    fill_in "Question", with: "Example question 1?"
    select "Short Answer", :from => "Question type"
    click_button "Submit"
    expect(page).to have_content("Question created successfully.")
  end

  it "create and show numeric question" do
    visit new_question_path
    fill_in "Question", with: "Example question 2?"
    select "Numeric", :from => "Question type"
    click_button "Submit"
    expect(page).to have_content("Question created successfully.")
  end
end

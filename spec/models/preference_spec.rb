
require 'rails_helper'

# Answer Model Unit Test
RSpec.describe Preference, type: :model do
  # Testing short answer
  it 'short answer is valid with valid attributes' do
    PreferenceForm.create(id: 1, title: 'test', num_prefs: 2, num_antiprefs: 1, active: TRUE)
    expect(Preference.new(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: "Preference", why: "Test")).to be_valid
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# Checks that preference can be created, read, and deleted.
RSpec.describe Preference, type: :model do
  before(:all) do
    PreferenceForm.create(id: 1, title: 'test', num_prefs: 2, num_antiprefs: 1, active: TRUE)
    @pref = Preference.create(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: "Preference", why: "Test")
  end

  it 'checks that a preference can be created' do
    expect(@pref).to be_valid
  end

  it 'checks that a preference can be destroyed' do
    previous_pref_count = Preference.count
    @pref.destroy
    expect(Preference.count).to be < previous_pref_count
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

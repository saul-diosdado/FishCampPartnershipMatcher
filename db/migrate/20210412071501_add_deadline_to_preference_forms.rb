# frozen_string_literal: true

class AddDeadlineToPreferenceForms < ActiveRecord::Migration[6.1]
  def change
    add_column :preference_forms, :deadline, :datetime
  end
end

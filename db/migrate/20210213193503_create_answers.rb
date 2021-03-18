# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.belongs_to :user
      t.belongs_to :question
      t.belongs_to :preference_form
      t.string :answer_type
      t.text :short_answer
      t.boolean :true_false
      t.integer :numeric
      t.string :multiple_choice

      t.timestamps
    end
  end
end

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.belongs_to :preference_form
      t.text :question
      t.string :question_type

      t.timestamps
    end
  end
end

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.string :type
      t.string :choices, array: true

      t.timestamps
    end
  end
end

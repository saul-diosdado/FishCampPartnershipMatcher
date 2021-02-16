class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.belongs_to :user
      t.belongs_to :question
      t.text :short_answer
      t.boolean :true_false
      t.integer :numeric

      t.timestamps
    end
  end
end

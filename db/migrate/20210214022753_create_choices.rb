# frozen_string_literal: true

class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.text :content
      t.belongs_to :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end

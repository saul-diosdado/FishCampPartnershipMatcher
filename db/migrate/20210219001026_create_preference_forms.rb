# frozen_string_literal: true

class CreatePreferenceForms < ActiveRecord::Migration[6.1]
  def change
    create_table :preference_forms do |t|
      t.string :title
      t.integer :num_prefs
      t.integer :num_antiprefs
      t.boolean :active
      t.datetime :deadline
      t.bigint :submissions, array: true, default: []

      t.timestamps
    end
  end
end

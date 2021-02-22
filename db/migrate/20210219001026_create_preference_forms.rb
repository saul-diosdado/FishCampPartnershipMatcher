class CreatePreferenceForms < ActiveRecord::Migration[6.1]
  def change
    create_table :preference_forms do |t|
      t.belongs_to :creator, class_name: "User"
      t.integer :num_prefs
      t.integer :num_antiprefs

      t.timestamps
    end
  end
end

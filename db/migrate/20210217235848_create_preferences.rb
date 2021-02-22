class CreatePreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :preferences do |t|
      t.belongs_to :selector, class_name: "User"
      t.belongs_to :selected, class_name: "User"
      t.string :pref_type
      t.integer :rating
      t.text :why

      t.timestamps
    end
  end
end

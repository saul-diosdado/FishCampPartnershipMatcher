class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.belongs_to :user
      t.belongs_to :matched, class_name: "User"
      t.belongs_to :preference_form
      t.bigint :prospects_ids, array: true, default: []
      t.numeric :prospects_pref_averages, array: true, default: []

      t.timestamps
    end
  end
end

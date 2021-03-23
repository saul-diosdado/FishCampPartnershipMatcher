class AddEnneagramToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :enneagram, :string
  end
end

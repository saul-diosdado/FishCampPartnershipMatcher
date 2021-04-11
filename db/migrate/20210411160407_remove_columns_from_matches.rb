class RemoveColumnsFromMatches < ActiveRecord::Migration[6.1]
  def change
    remove_column :matches, :prospects_ids, :bigint
    remove_column :matches, :prospects_pref_averages, :decimal
  end
end

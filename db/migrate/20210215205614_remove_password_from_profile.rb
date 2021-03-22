# frozen_string_literal: true

class RemovePasswordFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :password, :string
  end
end

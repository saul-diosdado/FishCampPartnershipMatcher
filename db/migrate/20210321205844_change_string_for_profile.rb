# frozen_string_literal: true

class ChangeStringForProfile < ActiveRecord::Migration[6.1]
  def change
    change_column(:profiles, :gender, :string)
  end
end

# frozen_string_literal: true

class Anything < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :profiles, :users
  end
end

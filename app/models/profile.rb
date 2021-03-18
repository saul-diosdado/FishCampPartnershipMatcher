# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :users, optional: true

  validates_presence_of :name, :user_id, :email
end

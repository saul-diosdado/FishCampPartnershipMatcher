# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :user_id, :email
  attribute :aboutme, :string, default: ''
end

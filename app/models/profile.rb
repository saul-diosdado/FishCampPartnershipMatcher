# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :users, optional: true
  validates_presence_of :name, :user_id, :email
  validate :full_name?
  attribute :aboutme, :string, default: ''

  def full_name?
    errors.add(:base, 'Name must contain first and last name') if !name.nil? && !name.include?(' ')
  end
end

# frozen_string_literal: true

class Profile < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user
  validates_presence_of :name, :user_id, :email
  validate :full_name?
  attribute :aboutme, :string, default: ''

  def full_name?
    errors.add(:base, 'Must enter first and last name') unless name.include? " " || name.nil?
  end
end

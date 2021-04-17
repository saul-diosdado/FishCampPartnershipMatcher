# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  include Clearance::User

  has_many :answers, dependent: :delete_all
  has_many :preferences, foreign_key: 'selector_id', dependent: :delete_all
  has_one :match, dependent: :delete
  has_one :profile, dependent: :delete

  after_initialize :assign_default_role, if: :new_record?
  after_save :assign_admin_role

  validates_presence_of :name
  validate :full_name?

  def assign_default_role
    add_role(:chair)
  end

  def assign_admin_role
    return unless email == 'fcpartner123@gmail.com'

    remove_role(:chair)
    add_role(:admin)
  end

  # method to confirm user email on sign_up
  def confirm_email
    self.email_confirmed_at = Time.current
    save
  end

  def full_name?
    errors.add(:base, 'Name must contain first and last name') if !name.nil? && !name.include?(' ')
  end
end

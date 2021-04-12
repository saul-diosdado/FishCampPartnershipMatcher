# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  include Clearance::User

  after_initialize :assign_default_role, if: :new_record?
  after_save :assign_admin_role

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
end

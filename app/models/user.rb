# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  include Clearance::User

  after_initialize :assign_default_role, if: :new_record?

  def assign_default_role
    add_role(:chair)
  end
end

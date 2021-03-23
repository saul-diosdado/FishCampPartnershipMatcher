# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  include Clearance::User

  after_create :assign_default_role
  
end

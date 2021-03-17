class User < ApplicationRecord
  include Clearance::User
  has_one :match, dependent: :destroy
end

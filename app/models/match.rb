class Match < ApplicationRecord
    belongs_to :users, dependent: :destroy, optional: true
end

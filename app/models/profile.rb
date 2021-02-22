class Profile < ApplicationRecord
    belongs_to :users, optional: true
end

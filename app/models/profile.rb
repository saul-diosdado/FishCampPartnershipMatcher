# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :users, optional: true
  after_initialize :default_about_me
  validates_presence_of :name, :user_id, :email

  def default_about_me
    self.aboutme = ''
  end
end

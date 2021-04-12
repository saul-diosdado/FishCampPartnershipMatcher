# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  def check_if_approved
    approved = current_user.approved
    if !approved
      redirect_to('/unapproved_user/index', { flash: { danger: 'You need to be approved to access the site' } })
    end
  end
end

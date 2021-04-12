# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller

  # Before accessing this page, insure the user is a Director.
  def check_role
    return if current_user.has_role? :director

    redirect_to(root_path,
                { flash: { danger: 'WARNING: Only Directors have access to the matching pages.' } })

  end
  
  def check_if_approved
    approved = current_user.approved
    if !approved
      redirect_to('/unapproved_user/index', { flash: { danger: 'You need to be approved to access the site' } })
    end
  end
  
  module Admin
    class ApplicationController < Administrate::ApplicationController
      before_action :authenticate_user!
      before_action :authenticate_admin
      def authenticate_admin
        redirect_to '/', alert: 'Not authorized.' unless current_user && access?
      end
      private
      def access?
        current_user.has_role? :admin
      end
    end
  end
end

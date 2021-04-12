# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  
  
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

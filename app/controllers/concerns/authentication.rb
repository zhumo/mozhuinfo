module Concerns
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_filter :require_current_user
      helper_method :current_user
    end

    def authenticate!
      session[:user_id]
    end

    def current_user
      if session[:writer
    end
  end
end

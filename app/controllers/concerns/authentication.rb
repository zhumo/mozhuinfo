module Concerns
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_filter :require_session!
      helper_method :authenticated?
    end

    def require_session!
      unless authenticated?
        redirect_to login_path, flash: { error: 'Please login first' }
      end
    end

    def authenticated?
      gatekeeper.allow?
    end

    def gatekeeper
      @gatekeeper ||= Gatekeeper.new(session_key: session[:token])
    end
  end
end

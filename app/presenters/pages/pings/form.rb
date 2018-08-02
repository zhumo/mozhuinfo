module Pages
  module Pings
    class Form < Page

      attr_reader :user_record, :ping_record

      def initialize(view_context, user_record, ping_record = nil)
        initialize_view_context(view_context)
        @user_record = user_record
        @ping_record = ping_record || build_ping_record
      end

      def render_form(&block)
        form_for([@user_record, @ping_record], html: { class: "ping-form" }, &block)
      end

      def ping_algorithm_select_options
        options_for_select(Ping::VALID_ALGORITHMS.map { |alg| [alg.humanize, alg]})
      end

      def render_errors(f)
        render 'shared/form_errors', errors: f.object.errors
      end

      def save(ping_params)
        ping_record.assign_attributes(ping_params)
        ping_record.save
      end

      private

      def build_ping_record
        user_record.pings.new
      end
    end
  end
end

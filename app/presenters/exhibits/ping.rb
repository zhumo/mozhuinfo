module Exhibits
  class Ping < Exhibit
    exhibit_model :ping

    def message_preview
      truncate(message, length: 20)
    end

    def algorithm
      super.humanize
    end

    def formatted_next_ping
      next_ping_at.to_s
    end

    class << self
      def applicable_to?(object)
        object.is_a?(::Ping)
      end
    end
  end
end

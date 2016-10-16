module Concerns
  module Exhibits
    module ViewContext
      include Concerns::ViewContext

      delegate :truncate, to: :view_context
    end
  end
end

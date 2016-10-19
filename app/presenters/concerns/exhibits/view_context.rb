module Concerns
  module Exhibits
    module ViewContext
      include Concerns::ViewContext

      delegate :truncate, :markdown, to: :view_context
    end
  end
end

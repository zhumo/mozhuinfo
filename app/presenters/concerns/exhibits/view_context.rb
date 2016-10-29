module Concerns
  module Exhibits
    module ViewContext
      include Concerns::ViewContext

      delegate :authenticated?, :truncate, :markdown, to: :view_context
    end
  end
end

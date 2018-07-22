module Concerns
  module Exhibits
    module ViewContext
      include Concerns::ViewContext

      delegate :authenticated?, :truncate, :markdown,
        :number_to_phone,
        to: :view_context
    end
  end
end

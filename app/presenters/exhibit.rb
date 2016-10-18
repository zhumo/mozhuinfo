class Exhibit < SimpleDelegator
  include Concerns::Exhibits::ViewContext

  attr_reader :model

  def initialize(view_context, model)
    initialize_view_context(view_context)
    @model = model
    super(@model)
  end

  class << self
    def exhibits
      [
        Exhibits::Blog,
      ]
    end

    def exhibit_for(view_context, object)
      exhibits.inject(object) do |exhibit, obj|
        exhibit.exhibit_if_applicable(view_context, obj)
      end
    end

    def exhibit_if_applicable(view_context, object)
      if applicable_to?(object)
        new(view_context, object)
      else
        object
      end
    end

    def applicable_to?(object)
      warn "Object with no Exhibit #{object}"
      false
    end

    def exhibit_model(model_name)
      alias_method "#{model_name}_record".to_sym, :model
    end
  end

end

class Exhibit < SimpleDelegator
  include Concerns::Exhibits::ViewContext

  attr_reader :model

  def initialize(view_context, model)
    initialize_view_context(view_context)
    @model = model
    super(@model)
  end

  class << self
    def exhibit_for(view_context, model)
      case model
      when Blog; Exhibits::Blog.new(view_context, model)
      end
    end

    def exhibit_model(model_name)
      alias_method "#{model_name}_record".to_sym, :model
    end
  end

end

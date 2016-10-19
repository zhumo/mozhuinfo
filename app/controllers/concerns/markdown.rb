require 'kramdown'

module Concerns
  module Markdown
    extend ActiveSupport::Concern

    included do
      helper_method :markdown
    end

    def markdown(text)
      Kramdown::Document.new(text).to_html.html_safe
    end
  end
end

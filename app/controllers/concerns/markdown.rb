require 'kramdown'

module Concerns
  module Markdown
    extend ActiveSupport::Concern

    included do
      helper_method :markdown
    end

    def markdown(text)
      opts = {
        syntax_highlighter: 'rouge',
      }
      Kramdown::Document.new(text, opts).to_html.html_safe
    end
  end
end

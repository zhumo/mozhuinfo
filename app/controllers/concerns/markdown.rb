require 'kramdown'

module Concerns
  module Markdown
    extend ActiveSupport::Concern

    included do
      helper_method :markdown
    end

    def markdown(text)
      opts = {
        enable_coderay: true,
        syntax_highlighter_opts: {
          line_numbers: false,
        },
      }
      Kramdown::Document.new(text, opts).to_html.html_safe
    end
  end
end

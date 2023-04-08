module MarkdownRenderer
  def self.md_to_html(content)
    parser = Markup::Ast::MarkdownParser.new
    document = parser.parse(content)
    document.to_html.html_safe
  end
end

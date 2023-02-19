require "rouge/plugins/redcarpet"

module MarkdownRenderer
  class Renderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def rouge_formatter(lexer)
      Rouge::Formatters::HTMLLegacy.new(
        css_class: "line-numbers language-#{lexer.tag.strip}",
      )
    end
  end

  GithubFlavouredMarkdown = Redcarpet::Markdown.new(
    Renderer.new(
      link_attributes: { target: '_blank', rel: 'noopener' }
    ),
    tables: true,
    autolink: true,
    hard_wrap: true,
    highlight: true,
    superscript: true,
    strikethrough: true,
    with_toc_data: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    space_after_headers: false,
  )

  def self.md_to_html(content)
    GithubFlavouredMarkdown.render(content).html_safe
  end
end

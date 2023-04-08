require "test_helper"

class MarkdownTest < ActiveSupport::TestCase
  def setup
    @parser = TreeStand::Parser.new("markdown")
  end

  test "markdown" do
    markdown = <<~MARKDOWN
      # Hello World

      This is a test.
      of paragraphs.

      and

      of

      lists

      - one
      - two

      ## Subheading
    MARKDOWN

    tree = @parser.parse_string(markdown)

    assert_rendered(<<~HTML.chomp, markdown)
      <h1>Hello World</h1><p>This is a test.
      of paragraphs.</p><p>and</p><p>of</p><p>lists</p><ul>
      <li>one</li>
      <li>two</li>
      </ul><h2>Subheading</h2>
    HTML
  end

  private

  def assert_rendered(html, markdown)
    assert_equal(html, MarkdownRenderer.md_to_html(markdown))
  end
end

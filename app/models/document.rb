class Document
  attr_reader :body

  SAMPLE_BODY = <<~MARKDOWN
    ## What

    Logged in users can...

    testing some other\r
    \r
    types of content\r
    blocks.\r
    Are these all a single paragraph?

    ## Empty Card

    img here

    ```ruby
    def hello
      nil
    end
    ```
  MARKDOWN

  def initialize(body)
    @body = SAMPLE_BODY
  end

  def to_html
    MarkdownRenderer.md_to_html(body)
  end
end

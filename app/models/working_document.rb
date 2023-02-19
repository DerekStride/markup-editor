class WorkingDocument < ApplicationRecord
  def to_html = MarkdownRenderer.md_to_html(body)
  def document_type = pull? ? "pull" : "issue"
  def edit_url = "/#{owner}/#{repo_name}/#{document_type}/#{issue_number}"

  def apply(change_set)
    if change_set.from_a > body.length
      body << change_set.inserted
    else
      body[change_set.from_a...change_set.to_a] = change_set.inserted
    end
  end
end

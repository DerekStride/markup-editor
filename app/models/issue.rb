class Issue
  extend Forwardable

  GITHUB_URL = "https://github.com"

  def initialize(issue_data)
    @issue_data = issue_data
  end

  def_delegators(
    :@issue_data,
    :title,
    :number,
    :state,
    :body,
    :html_url,
    :pull_request,
    :repository_url,
  )

  def repo
    suffix = pull? ? "/pull/#{number}" : "/issue/#{number}"
    edit_url[1..].delete_suffix(suffix)
  end
  def edit_url = html_url.delete_prefix(GITHUB_URL)
  def pull? = !!pull_request
  def open? = state == "open"
  def document = Document.new(body, id: number)

  def octicon
    return "git-pull-request" if pull? && open?
    return "git-merge" if pull?
    return "issue-opened" if open?
    "issue-closed"
  end

  private

  URL_MATCHER = %r{/repos/(?<owner>\w+)/(?<repo_name>[^/]+)}
  def url_match = repository_url.match(URL_MATCHER)
end

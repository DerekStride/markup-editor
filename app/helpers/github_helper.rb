module GithubHelper
  def github_color_for(issue)
    return "fill-github-green" if issue.open?
    "fill-github-purple"
  end
end

class IssuesController < ApplicationController
  before_action :set_issue, only: [:edit]

  def edit
  end

  private

  def set_issue
    @issue = Issue.new(github.issue(repo, issue_params[:issue_number]))
  end

  def repo = "#{issue_params[:owner]}/#{issue_params[:repo]}"
  def issue_params = params.permit(:owner, :repo, :issue_number)
end

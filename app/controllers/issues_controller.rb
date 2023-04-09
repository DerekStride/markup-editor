class IssuesController < ApplicationController
  before_action :set_document

  ChangeSet = Struct.new(:from_a, :to_a, :from_b, :to_b, :inserted)

  def edit
  end

  def update
    @document.apply(change_set)
    @document.save!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("preview_card", partial: "issues/card")
      end
    end
  end

  def comment
    selection_start = comment_params[:selection_start]
    selection_start_offset = comment_params[:selection_start_offset]
    selection_end = comment_params[:selection_end]
    selection_end_offset = comment_params[:selection_end_offset]
    comment_content = comment_params[:comment]

    binding.b
    head :unimplemented
  end

  private

  # By using `find_or_initialize_by`, we avoid creating a new `WorkingDocument`
  # record until the user actually makes an edit to the document. This is
  # important because we don't want to create a record for every issue that is
  # opened in the repo, only the ones that are actually being edited.
  #
  # We can explore other options for cost saving in the future ideally we don't
  # need to persist the document body in the database at all.
  #
  # * The minimum viable solution is to use a background job to delete old
  #   `WorkingDocument` records.
  #
  # * The ideal solution is to not need to persist the document body at all.
  #   * We can send the document body to the server to render the preview card.
  #   * We can use `ActionCable` to broadcast the `ChangeSet` to all connected
  #     clients so they can update their codemirror editors.
  #   * We could also use `ActionCable` to broadcast the updated preview card.
  #   * :warn: Updates could be lost on page refresh, need to investigate local
  #     storage options.
  #   * Newly connected clients would need to fetch the latest document body
  #     state via `ActionCable` from another connected client.
  #   * When multiple client rejoin with different copies of the body we need
  #     to generate and resolve/surface merge conflicts.
  #
  # Using the ChangeSet to update comment positions is the trickiest part of
  # this application so I'm going to focus on that first. This comment should
  # be sufficient documentation for next steps in this problem domain.
  def set_document
    @document = WorkingDocument.find_or_initialize_by(issue_params) do |doc|
      issue = Issue.new(github.issue(repo, issue_params[:issue_number]))
      doc.issue_title = issue.title
      doc.pull = issue.pull?
      doc.body = issue.body.gsub("\r", "")
    end
  end

  def repo = "#{issue_params[:owner]}/#{issue_params[:repo_name]}"
  def issue_params = params.permit(:owner, :repo_name, :issue_number)
  def document_params = params.permit(:from_a, :to_a, :from_b, :to_b, :inserted)
  def comment_params = params.permit(:comment, :selection_start, :selection_start_offset, :selection_end, :selection_end_offset)

  def change_set
    ChangeSet.new(
      document_params[:from_a].to_i,
      document_params[:to_a].to_i,
      document_params[:from_b].to_i,
      document_params[:to_b].to_i,
      document_params[:inserted],
    )
  end
end

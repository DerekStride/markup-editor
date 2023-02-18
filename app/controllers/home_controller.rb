class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
  end

  def search
    if search_query.present?
      @search_data = github.search_issues(search_query)
      @issues = @search_data.items.map { |item| Issue.new(item) }
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("issue_card", partial: "home/card")
      end
    end
  end

  private

  def search_query = search_params[:q]
  def search_params = params.permit(:q)
end

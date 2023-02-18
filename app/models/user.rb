class User
  attr_reader :github

  def initialize(user_session)
    @user_session = user_session
    @github = Octokit::Client.new(access_token: access_token)
  end

  def nickname = user.dig("info", "nickname")
  def name = user.dig("info", "name")

  private

  def user = @user_session
  def access_token = user.dig("credentials", "token")
end

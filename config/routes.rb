Rails.application.routes.draw do
  root "home#index"
  post "/", to: "home#search"

  get "auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#delete"

  get ":owner/:repo_name/issues/:issue_number", to: "issues#edit"
  get ":owner/:repo_name/pull/:issue_number", to: "issues#edit"
  post ":owner/:repo_name/issues/:issue_number", to: "issues#update"
  post ":owner/:repo_name/pull/:issue_number", to: "issues#update"
  post ":owner/:repo_name/issues/:issue_number/comment", to: "issues#comment"
  post ":owner/:repo_name/pull/:issue_number/comment", to: "issues#comment"
end

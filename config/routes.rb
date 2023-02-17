Rails.application.routes.draw do
  root "home#index"
  post "/", to: "home#search"

  get "auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#delete"

  get ":owner/:repo/issues/:issue_number", to: "issues#edit"
  get ":owner/:repo/pull/:issue_number", to: "issues#edit"
end

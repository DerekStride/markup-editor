source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "bootsnap", require: false

gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"

gem "sprockets-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"

gem "omniauth"
gem "omniauth-rails_csrf_protection"
gem "omniauth-github"

gem "octokit"
gem "octicons_helper"

gem "redcarpet", "~> 3.6"
gem "rouge", "~> 4.1"

group :development, :test do
  gem "pry-byebug"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

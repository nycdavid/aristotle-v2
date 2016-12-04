source 'https://rubygems.org'

ruby "2.2.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use SCSS for stylesheets
gem 'pg'
gem "jwt", "~> 1.5.4"

gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
gem 'chronic'
gem "foreman"

# Front End stuff
gem 'haml'
gem 'haml-rails'
gem 'sass-rails'
gem "font-awesome-rails"
gem 'angularjs-rails'
gem 'angular_rails_csrf'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem "react-rails", "~> 1.1.0"
gem "chartjs-ror", "~> 2.1.1"
gem "browserify-rails", "~> 1.4.0"
gem "responders", "~> 2.1.0"
gem "cancancan", "~> 1.10"

group :production do
  gem 'rails_12factor'
  gem "puma", "~> 2.16.0"
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'pry'
  gem 'faker'
  gem 'capybara-webkit'
  gem 'rack_session_access'
  gem 'timecop'
end

group :test, :development do
  gem "letter_opener"
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

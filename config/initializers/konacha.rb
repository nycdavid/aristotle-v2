require 'capybara/poltergeist'

Konacha.configure do |config|
  config.spec_dir = 'spec/javascripts/ng_pomodoro'
  config.driver = :poltergeist
end if defined?(Konacha)

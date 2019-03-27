require "koala"

Koala.configure do |config|
  config.app_id = ENV["app_id"]
  config.app_secret = ENV["app_secret"]
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end

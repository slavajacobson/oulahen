# initializers/mailjet.rb
Mailjet.configure do |config|
  config.api_key = ENV['mailjet_api_key']
  config.secret_key = ENV['mailjet_private_key']
  config.default_from = 'vs.jacobson@gmail.com'
end
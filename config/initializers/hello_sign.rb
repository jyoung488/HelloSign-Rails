require 'hello_sign'
HelloSign.configure do |config|
  config.api_key = '0f09c444c7b8b650844cfb4ceb387191a02b9e3ca241c757574d72448080ebd6'
  # You can use email_address and password instead of api_key. But api_key is recommended
  # If api_key, email_address and password are all present, api_key will be used
  # config.email_address = 'email_address'
  # config.password = 'password'
end

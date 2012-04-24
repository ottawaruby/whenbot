require 'whenbot'

# Add your installed Channels here.
Whenbot.config do |config|
  config.channels << Whenbot::Channels::Developer
  config.channels << Whenbot::Channels::Twitter
end
source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  
  gem 'less-rails-bootstrap'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'haml-rails'
gem 'jquery-rails'

# Form builders
gem 'simple_form'

gem 'heroku'

group :test, :development do  
  gem 'awesome_print'
  gem 'factory_girl_rails'
end

group :development do
  #gem 'ruby-debug19', :require => 'ruby-debug' # To use debugger
  gem 'rails-footnotes', '>= 3.7'
  
  # Silence asset messages in the development log
  gem 'quiet_assets'
end

group :test do
  gem 'test-unit' # not bundled with ruby 1.9
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git' # For #has_text?
  gem 'database_cleaner' # For Capybara. See test_helper.rb for details  
  gem 'mocha', :require => false  
  gem 'shoulda'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

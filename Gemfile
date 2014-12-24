source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'coffee-rails', '~> 4.1.0'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails', '~> 4.0.0'
gem 'haml'
gem 'pg'
gem 'rails', '4.2.0.rc3'
gem 'sqlite3'
gem 'rspotify', github: 'jaredmoody/rspotify'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rails-assets-chartjs', '~>1.0.1.beta4'
gem 'rails-assets-semantic-ui'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :production do
  gem 'thin'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0.0.beta4'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'guard-pow'
end

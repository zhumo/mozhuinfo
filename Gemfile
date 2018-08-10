source 'https://rubygems.org'
ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0'
gem 'pg', '~> 1.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'haml-rails', '~> 1.0'
gem 'kramdown', '~> 1.12' # Markdown
gem 'rouge', '~> 3.0' # Syntax highlighting for markdown

group :development, :test do
  gem 'pry-rails', '~> 0.3'
  gem 'dotenv-rails', '~> 2.1'
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'valid_attribute', '~> 2.0'
  gem 'database_cleaner', '~> 1.5'
  gem 'timecop', '~> 0.8'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'capybara', '~> 3.5'
  gem 'launchy', '~> 2.4' # ruby wrapper for launching a browser. Enables capybara's save_and_open_page
end

group :assets do
  gem 'coffee-rails', '~> 4.2.0' # TODO: idk why, but asset precompile requires coffee
end

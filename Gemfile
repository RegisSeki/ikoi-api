source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug', '~> 3.4'
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'faker', '~> 2.13'
  gem 'factory_bot_rails', '~> 6.0'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

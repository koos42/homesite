ruby '2.6.6'

source 'http://rubygems.org'

gem 'rails', '3.0.19'
gem 'jquery-rails', '>= 1.0.12'
gem 'rake', '13.0.3'
gem 'devise'
gem 'aws-s3'
gem 'paperclip', '~> 4.0'
gem 'aws-sdk'
gem 'pg'
gem 'unicorn'
gem 'newrelic_rpm'

group :development, :test do
  %w[ rspec rspec-core rspec-expectations rspec-mocks rspec-support rspec-rails ].each do |lib|
    gem lib, github: "rspec/#{lib}"
  end
  gem 'sqlite3'
  gem 'debugger'
  gem 'database_cleaner'
  gem 'pry'
end

group :production do
  # stuff
end


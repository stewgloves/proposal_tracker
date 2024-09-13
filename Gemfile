source "https://rubygems.org"

ruby "3.3.4"

# Rails framework
gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# Asset pipeline
gem "sprockets-rails"

# PostgreSQL as the database for Active Record
gem "pg", "~> 1.1"

# Puma web server
gem "puma", ">= 5.0"

# Import maps for managing JavaScript dependencies
gem "importmap-rails"

# Hotwire Turbo for accelerated navigation
gem "turbo-rails"

# Hotwire Stimulus for modest JavaScript
gem "stimulus-rails"

# Tailwind CSS for styling
gem "tailwindcss-rails"

# Jbuilder for building JSON APIs
gem "jbuilder"

# Time zone data for Windows
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Bootsnap to speed up boot times
gem "bootsnap", require: false

# RSpec for testing
gem "rspec-rails", "~> 7.0", groups: [:development, :test]

# Devise for user authentication
gem "devise", "~> 4.9"

# Pundit for authorization
gem "pundit", "~> 2.4"

# Sidekiq for background jobs
gem "sidekiq", "~> 7.3"

# Ransack for search and filtering
gem "ransack", "~> 4.2"

# Kaminari for pagination
gem "kaminari", "~> 1.2"

# AASM for state machines (proposal workflow)
gem "aasm", "~> 5.3"

# PaperTrail for activity logging
gem "paper_trail", "~> 12.0"

# ActsAsCommentableWithThreading for threaded comments
gem "acts_as_commentable_with_threading", "~> 2.0.1"

# Slack Ruby Client for Slack integration
gem "slack-ruby-client", "~> 2.4.0"

# Chartkick for charts and graphs
gem "chartkick", "~> 4.0"

# Groupdate for grouping data in charts
gem "groupdate", "~> 6.1"

# dotenv-rails for managing environment variables
gem "dotenv-rails", groups: [:development, :test]

# FactoryBot for testing
gem "factory_bot_rails", "~> 6.4.3", groups: [:development, :test]

# Faker for generating test data
gem "faker", "~> 3.0", groups: [:development, :test]

# CSV export capabilities
gem "csv", "~> 3.1"

gem 'whenever', require: false

group :development, :test do
  # Debugging tools
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Web console for debugging in the browser
  gem "web-console"

  # Spring for faster Rails commands
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # Rack Mini Profiler for performance profiling
  gem "rack-mini-profiler"
end

group :production do
  # Redis for Action Cable and Sidekiq in production
  gem "redis", "~> 4.0"
end

# Use Active Storage variants
gem "image_processing", "~> 1.2"

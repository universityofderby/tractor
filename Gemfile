source :rubygems

group :test do
    gem 'rake'
    gem 'cucumber'
    gem 'aruba'
    gem 'rspec'
    gem 'factory_girl'
    gem 'simplecov'
end

group :development do
    gem 'travis-lint'
    gem 'guard-cucumber'
    gem 'guard-rspec'
    gem 'rb-readline'
    gem 'rb-inotify' if RUBY_PLATFORM.downcase.include?("linux")
    gem 'rb-fsevent' if RUBY_PLATFORM.downcase.include?("darwin")
end

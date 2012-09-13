require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :tests

desc "Run tests"
task :tests do 
    Rake::Task['features'].invoke
    Rake::Task['specs'].invoke
end

desc "Run features"
Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format progress"
end

desc "Run specs"
RSpec::Core::RakeTask.new(:specs) do |t|
    t.rspec_opts = "--format progress"
end


require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new
RuboCop::RakeTask.new

task default: %i[spec cucumber rubocop]

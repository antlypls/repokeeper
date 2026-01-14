GEM_ROOT = File.expand_path('..', __dir__)
$LOAD_PATH.unshift File.join(GEM_ROOT, 'lib')

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
  enable_coverage :branch
end

require 'repokeeper'

require 'rspec/collection_matchers'

Dir[File.join(__dir__, 'support/**/*.rb')].sort.each { |f| require f }
Dir[File.join(__dir__, 'analyzers/shared_examples/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include SpecHelpers::FakeCommit
  config.include SpecHelpers::RepoFixture
  config.extend SpecHelpers::FileHelpers
end

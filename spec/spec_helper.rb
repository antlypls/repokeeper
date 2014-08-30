GEM_ROOT = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift File.join(GEM_ROOT, 'lib')

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
  SimpleCov.start
end

require 'repokeeper'

require 'rspec/collection_matchers'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
Dir['./spec/analyzers/shared_examples/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.include SpecHelpers::FakeCommit
  config.include SpecHelpers::RepoFixture
  config.extend SpecHelpers::FileHelpers
end

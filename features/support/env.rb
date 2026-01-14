require 'aruba/cucumber'
require 'fileutils'

bin_dir = File.expand_path('../../bin', __dir__)
ENV['PATH'] = "#{bin_dir}#{File::PATH_SEPARATOR}#{ENV.fetch('PATH', nil)}"

Aruba.configure do |config|
  config.exit_timeout = 10
  config.io_wait_timeout = 2
end

# Make current_dir available in step definitions
World(Aruba::Api)

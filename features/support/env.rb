require 'aruba/cucumber'
require 'fileutils'

bin_dir = File.expand_path(File.dirname(__FILE__) + '/../../bin')
ENV['PATH'] = "#{bin_dir}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

# increase timeout to avoid timeouts when run with rbx
Before do
  @aruba_timeout_seconds = 10
end

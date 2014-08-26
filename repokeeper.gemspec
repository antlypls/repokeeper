lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repokeeper/version'

Gem::Specification.new do |spec|
  spec.name          = 'repokeeper'
  spec.version       = Repokeeper::VERSION
  spec.authors       = ['Anatoliy Plastinin']
  spec.email         = ['hello@antlypls.com']
  spec.summary       = 'Repokeeper - git repo analysis tool'
  spec.description   = <<-DESCR
Repokeeper is a tool for analysis of git repositotories
for common flaws in a workflow.
DESCR
  spec.homepage      = 'https://github.com/antlypls/repokeeper'
  spec.license       = 'GPLv3'

  spec.files         = %w(README.md LICENSE GPLv3)
  spec.files         += Dir.glob('lib/**/*.rb')
  spec.files         += Dir.glob('bin/**/*')
  spec.files         += Dir.glob('config/**/*')

  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rugged', '~> 0.21'
  spec.add_dependency 'methadone'
  spec.add_dependency 'levenshtein-ffi', '~> 1.1.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
end

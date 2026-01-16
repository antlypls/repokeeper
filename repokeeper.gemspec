lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repokeeper/version'

Gem::Specification.new do |spec|
  spec.name          = 'repokeeper'
  spec.version       = Repokeeper::VERSION
  spec.authors       = ['Anatoliy Plastinin']
  spec.email         = ['hello@antlypls.com']
  spec.summary       = 'Repokeeper - git repo analysis tool'
  spec.description   = <<~DESCR
    Repokeeper is a tool for analysis of git repositories
    for common flaws in a workflow.
  DESCR
  spec.homepage      = 'https://github.com/antlypls/repokeeper'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.3.0'

  spec.files         = %w[README.md LICENSE]
  spec.files         += Dir.glob('lib/**/*.rb')
  spec.files         += Dir.glob('bin/**/*')
  spec.files         += Dir.glob('config/**/*')

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rugged', '~> 1.9'
  spec.add_dependency 'thor', '~> 1.3'
end

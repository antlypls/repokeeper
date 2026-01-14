require 'thor'

module Repokeeper
  class CLI < Thor
    package_name 'repokeeper'

    def self.exit_on_failure?
      true
    end

    desc 'analyze [PATH]', 'Analyze a git repository for common workflow flaws'
    option :rev_range, aliases: '-r', desc: 'Revisions to analyze by commits analyzers'
    option :config, aliases: '-c', desc: 'Configuration file path'
    option :require, desc: 'File to require'
    option :formatter, desc: 'Formatter class name'

    def analyze(path = '.')
      file_to_require = options[:require]
      require file_to_require if file_to_require

      formatter_class = formatter_class_by_name(options[:formatter])
      config_file = options[:config]
      repo_analyzer = create_analyzer(path, config_file, formatter_class)
      range = rev_range(options[:rev_range])
      repo_analyzer.analyze(range)
    end

    desc 'version', 'Print version information'
    def version
      puts "repokeeper #{VERSION}"
    end

    default_task :analyze

    map %w[--version -v] => :version

    # Handle unknown arguments as paths for the analyze command
    def self.start(given_args = ARGV, config = {})
      # If first argument exists and is not a known command or flag, treat it as path for analyze
      if given_args.any? && !given_args.first.start_with?('-')
        first_arg = given_args.first
        unless %w[analyze version help tree].include?(first_arg) || first_arg.start_with?('-')
          # Looks like a path, prepend 'analyze'
          given_args = ['analyze'] + given_args
        end
      end
      super
    end

    private

    def formatter_class_by_name(name)
      if name && !name.empty?
        Object.const_get(name)
      else
        SimpleTextFormatter
      end
    end

    def create_analyzer(path, config_file, formatter_class)
      formatter = formatter_class.new
      analyzers = Analyzers::Analyzer.all
      proxy = RepoProxy.new(path)
      config = Config.read(config_file)
      RepoAnalyzer.new(proxy, formatter, analyzers, config)
    end

    def rev_range(rev_spec)
      parser = RevParser.new(rev_spec)
      parser.parse
      parser.range
    end
  end
end

require 'methadone'

module Repokeeper
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    version VERSION, compact: true
    description 'Repokeeper checks your repo for flaws'

    arg :path, :optional,
        'path to repo to analyze, current dir if not specified'

    on '-r REV_RANGE', '--rev-range',
       'Revisions to analyze by commits analyzers'

    on '-c CONFIG_FILE', '--config',
       'Configuration file'

    on '--require REQUIRE_FILE',
       'File to require'

    on '--formatter FORMATTER_CLASS',
       'Formatter class'

    main do |path|
      file_to_require = options['require']
      require file_to_require if file_to_require

      formatter_class = formatter_class_by_name(options['formatter'])

      config_file = options['config']
      repo_analyzer = create_analyzer(path, config_file, formatter_class)
      range = rev_range(options['rev-range'])
      repo_analyzer.analyze(range)
    end

    def self.formatter_class_by_name(name)
      if name && !name.empty?
        const_get(name)
      else
        SimpleTextFormatter
      end
    end

    def self.create_analyzer(path, config_file, formatter_class)
      formatter = formatter_class.new

      analyzers = Analyzers::Analyzer.all

      proxy = RepoProxy.new(path)
      config = Config.read(config_file)
      RepoAnalyzer.new(proxy, formatter, analyzers, config)
    end

    def self.rev_range(rev_spec)
      parser = RevParser.new(rev_spec)
      parser.parse
      parser.range
    end
  end
end

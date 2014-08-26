module Repokeeper
  # provides infrastructure for running commits analyzers
  class RepoAnalyzer
    def initialize(repo_proxy, formatter, analyzers, config)
      @analyzers = analyzers
      @formatter = formatter
      @repo = repo_proxy
      @config = config
    end

    def analyze(rev_range = nil)
      @rev_range = rev_range

      @formatter.started
      run_commits_analyzers
      run_branches_analyzers
      @formatter.finished
    end

    private

    def commits_analyzers
      @analyzers.commits_analyzers
    end

    def branch_analyzers
      @analyzers.branch_analyzers
    end

    def enabled_analyzers(collection)
      collection
        .map { |analyzer_class| instantiate_analyzer(analyzer_class) }
        .select { |analyzer| analyzer.enabled? }
    end

    def enabled_commits_analyzers
      @enabled_commits_analyzers ||= enabled_analyzers(commits_analyzers)
    end

    def enabled_branches_analyzers
      @enabled_branches_analyzers ||= enabled_analyzers(branch_analyzers)
    end

    def run_commits_analyzers
      commits.each do |commit|
        enabled_commits_analyzers.each do |analyzer|
          result = analyzer.process_commit(commit)
          @formatter.commits_analyzer_results(analyzer.name, result)
        end
      end
    end

    def run_branches_analyzers
      enabled_branches_analyzers.each do |analyzer|
        result = analyzer.analyze(@repo)
        @formatter.branches_analyzer_results(analyzer.name, result)
      end
    end

    def instantiate_analyzer(analyzer_class)
      analyzer_class.new(@config.for(analyzer_class))
    end

    def commits
      @commits ||= @repo.commits(@rev_range)
    end
  end
end

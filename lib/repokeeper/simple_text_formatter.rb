module Repokeeper
  class SimpleTextFormatter
    def initialize(out_stream = $stdout)
      @out_stream = out_stream
    end

    def started
      @commits = Hash.new { |h, k| h[k] = [] }
      @branches = Hash.new { |h, k| h[k] = [] }
    end

    def commits_analyzer_results(analyzer_name, offenses)
      @commits[analyzer_name].concat(Array(offenses))
    end

    def branches_analyzer_results(analyzer_name, offenses)
      @branches[analyzer_name].concat(Array(offenses))
    end

    def finished
      write_results(@commits, :commit_offense_message)
      write_results(@branches, :branch_offense_message)
    end

    private

    def write_results(collection, write_offense_method)
      collection.keys.sort.each do |analyzer_name|
        offenses = collection[analyzer_name].compact
        write_analyzer_results(analyzer_name, offenses, write_offense_method)
      end
    end

    def write_analyzer_results(analyzer_name, offenses, write_offense_method)
      @out_stream.puts "=== #{analyzer_name} ==="

      if offenses.empty?
        @out_stream.puts 'No issues were found'
      else
        offenses.each do |offense|
          @out_stream.puts send(write_offense_method, offense)
        end
      end

      @out_stream.puts
    end

    def commit_offense_message(offense)
      error_message = offense.message
      commit = offense.commit
      id = commit.oid
      author = commit.author[:name]

      "#{id} by #{author}. #{error_message}"
    end

    def branch_offense_message(offense)
      error_message = offense.message
      branches = offense.branches.join(', ')

      "#{error_message} - #{branches}"
    end
  end
end

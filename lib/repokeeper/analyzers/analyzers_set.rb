module Repokeeper::Analyzers
  class AnalyzersSet < Array
    def commits_analyzers
      select { |a| a.type == :commit }
    end

    def branch_analyzers
      select { |a| a.type == :branch }
    end
  end
end

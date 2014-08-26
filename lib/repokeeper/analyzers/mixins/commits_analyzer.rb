module Repokeeper::Analyzers
  module CommitsAnalyzer
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def type
        :commit
      end
    end

    private

    def create_offense(commit, message)
      Repokeeper::Offenses::CommitOffense.new(commit, message, name)
    end
  end
end

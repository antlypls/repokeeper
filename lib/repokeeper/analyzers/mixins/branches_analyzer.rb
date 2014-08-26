module Repokeeper::Analyzers
  module BranchesAnalyzer
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def type
        :branch
      end
    end
  end
end

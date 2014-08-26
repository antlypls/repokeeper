module Repokeeper::Analyzers
  # Base class for sequential commits analyzers
  class Analyzer
    @all = AnalyzersSet.new

    def self.all
      @all.clone
    end

    def self.inherited(subclass)
      @all << subclass
    end

    def initialize(config)
      @config = config || {}
    end

    def name
      self.class.name.split('::').last
    end

    def enabled?
      @config.fetch('enabled') { true }
    end
  end
end

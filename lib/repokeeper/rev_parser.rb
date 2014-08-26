module Repokeeper
  # Parser for revision or revision range
  class RevParser
    RevRange = Struct.new(:end_rev, :start_rev)

    attr_reader :range

    def initialize(revisions = nil)
      @revisions = revisions || ''
    end

    def parse
      @range = RevRange.new(*parse_revs)
    end

    private

    def parse_revs
      @revisions.split('..').reverse
    end
  end
end

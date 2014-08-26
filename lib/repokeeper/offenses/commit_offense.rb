module Repokeeper
  module Offenses
    class CommitOffense < Struct.new(:commit, :message, :analyzer_name)
      # we want Array(offense) to return [offense]
      undef_method :to_a
    end
  end
end

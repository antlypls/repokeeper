module Repokeeper
  module Offenses
    CommitOffense = Struct.new(:commit, :message, :analyzer_name) do
      # we want Array(offense) to return [offense]
      undef_method :to_a
    end
  end
end

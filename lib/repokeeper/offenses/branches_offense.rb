module Repokeeper
  module Offenses
    BranchesOffense = Struct.new(:branches, :message, :analyzer_name) do
      # we want Array(offense) to return [offense]
      undef_method :to_a
    end
  end
end

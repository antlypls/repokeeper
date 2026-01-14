module Repokeeper
  module Utils
    # Calculates Levenshtein distance between two strings
    # Using Ruby's built-in implementation
    def self.edit_distance(str1, str2)
      DidYouMean::Levenshtein.distance(str1.to_s, str2.to_s)
    end
  end
end

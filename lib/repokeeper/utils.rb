require 'levenshtein'

module Repokeeper
  module Utils
    # calculates levinstein distance of two strings
    def self.edit_distance(str1, str2)
      Levenshtein.distance(str1, str2)
    end
  end
end

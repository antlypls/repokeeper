require 'securerandom'

module SpecHelpers
  module FakeCommit
    class Commit
      attr_reader :message
      attr_reader :oid
      attr_reader :author
      attr_reader :parents

      def initialize(opts = {})
        @message = opts[:message] || 'commit message'
        @oid = opts[:oid] || SecureRandom.hex(20)
        @author = opts[:author] || {
          email: 'example@example.com',
          name: 'Dummy Dummy'
        }

        @parents = opts[:parents] || []
      end
    end

    def fake_commit(*args)
      Commit.new(*args)
    end
  end
end

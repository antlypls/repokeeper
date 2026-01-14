require 'tempfile'
require 'tmpdir'

module SpecHelpers
  module RepoFixture
    def self.included(base)
      base.extend ClassHelpers
    end

    module ClassHelpers
      def setup_test_repo(repo_name = 'test_repo')
        before(:all) do
          init_test_repo(repo_name)
        end

        after(:all) do
          remove_test_repo
        end
      end
    end

    FIXTURE_DIR = File.expand_path('../../fixtures', __dir__)

    def init_test_repo(repo_name)
      @_test_repo_path = Dir.mktmpdir('repokeeper_test')
      FileUtils.cp_r(File.join(FIXTURE_DIR, repo_name), @_test_repo_path)

      Dir.chdir(File.join(@_test_repo_path, repo_name)) do
        File.rename('.gitted', '.git') if File.exist?('.gitted')
      end

      @_full_test_repo_path = File.join(@_test_repo_path, repo_name)
    end

    def remove_test_repo
      FileUtils.remove_entry_secure @_test_repo_path
    end

    def test_repo_path
      @_full_test_repo_path
    end
  end
end

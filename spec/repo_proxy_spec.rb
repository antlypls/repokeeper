require 'spec_helper'

describe Repokeeper::RepoProxy do
  subject(:proxy) { described_class.new(test_repo_path) }

  describe '#commits' do
    setup_test_repo

    it 'returns all reachable history from HEAD if no args provided' do
      expect(proxy.commits).to have(6).items
    end

    it 'returns all reachable history from start_rev' do
      range = Repokeeper::RevParser::RevRange.new('feature')
      expect(proxy.commits(range)).to have(5).items
    end

    it 'returns reachable history from start_rev to end_rev' do
      range = Repokeeper::RevParser::RevRange.new('feature', 'master')
      expect(proxy.commits(range)).to have(2).items
    end

    it 'returns commits in right order (from recent to older)' do
      commits = proxy.commits
      expect(commits.first.oid)
        .to eq('73f92f4a58173e651a5605d7c9384c6ea524df8a')

      expect(commits.last.oid)
        .to eq('7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2')
    end
  end

  describe '#local_branches' do
    setup_test_repo('many_branches_repo')

    it 'returns a list of local branches' do
      expect(proxy.local_branches)
        .to match_array(%w[five four master one six three two])
    end
  end

  describe '#remote_branches' do
    setup_test_repo('many_branches_repo')

    it 'returns a list of remote branches' do
      expect(proxy.remote_branches)
        .to match_array(%w[
          origin/five
          origin/four
          origin/master
          origin/one
          origin/three
          origin/two
        ])
    end
  end
end

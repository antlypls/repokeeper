require 'spec_helper'

describe Repokeeper::Analyzers::MergeCommits do
  subject(:analyzer) { described_class.new({}) }

  include_examples 'commit_analyzer'

  describe '#process_commit' do
    subject(:result) { analyzer.process_commit(commit) }

    context 'when commit with 2 parents' do
      let(:commit) { fake_commit(parents: [fake_commit, fake_commit]) }

      it 'rerturns offense' do
        expect(result).to be_a(Repokeeper::Offenses::CommitOffense)
        expect(result.commit).to eq(commit)
      end
    end

    context 'when commit with 1 parent' do
      let(:commit) { fake_commit(parents: [fake_commit]) }

      it 'rerturns nil' do
        expect(result).to be_nil
      end
    end
  end
end

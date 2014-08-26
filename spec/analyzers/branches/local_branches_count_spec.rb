require 'spec_helper'

describe Repokeeper::Analyzers::LocalBranchesCount do
  let(:config) { { 'max_local_branches' => 5 } }
  subject(:analyzer) { described_class.new(config) }

  include_examples 'branch_analyzer'

  it 'has non-empty settings' do
    expect(analyzer.max_branches).not_to be_nil
  end

  describe '#analyze' do
    let(:repo_proxy) { double(:proxy, local_branches: local_branches) }
    subject(:result) { analyzer.analyze(repo_proxy) }

    context 'when repo has number of local branches less than a threshold ' do
      let(:local_branches) { %w(master) }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end

    context 'repo contains many local branches, more than a threshold' do
      let(:local_branches) { %w(one two three four five six) }

      it 'returns offense with bracnhes info' do
        expect(result.branches).to have(local_branches.count).items
      end
    end
  end
end

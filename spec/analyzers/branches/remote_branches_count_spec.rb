require 'spec_helper'

describe Repokeeper::Analyzers::RemoteBranchesCount do
  let(:config) { { 'max_remote_branches' => 5 } }
  subject(:analyzer) { described_class.new(config) }

  include_examples 'branch_analyzer'

  it 'has non-empty settings' do
    expect(analyzer.max_branches).not_to be_nil
  end

  describe '#analyze' do
    let(:repo_proxy) { double(:proxy, remote_branches: remote_branches) }
    subject(:result) { analyzer.analyze(repo_proxy) }

    context 'when repo has number of remote branches less than a threshold ' do
      let(:remote_branches) { %w(origin/master) }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end

    context 'repo contains many remote branches, more than a threshold' do
      let(:remote_branches) {
        %w(HEAD one two three four five).map { |b| "origin/#{b}" }
      }

      it 'result returns offense with bracnhes info' do
        expect(result.branches).to have(remote_branches.count).items
      end
    end
  end
end

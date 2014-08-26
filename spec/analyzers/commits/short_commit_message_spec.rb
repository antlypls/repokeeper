require 'spec_helper'

describe Repokeeper::Analyzers::ShortCommitMessage do
  let(:config) { { 'message_min_length' => 10 } }
  subject(:analyzer) { described_class.new(config) }

  include_examples 'commit_analyzer'

  it 'has non-empty settings' do
    expect(analyzer.message_min_length).not_to be_nil
  end

  describe '#process_commit' do
    subject(:result) { analyzer.process_commit(commit) }

    context 'when commit with short messasge' do
      let(:commit) { fake_commit(message: '!') }

      it 'returns offense' do
        expect(result).to be_a(Repokeeper::Offenses::CommitOffense)
      end
    end

    context 'when commit with long message' do
      let(:commit) { fake_commit(message: 'some very long commit message') }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end

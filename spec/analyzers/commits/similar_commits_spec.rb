require 'spec_helper'

describe Repokeeper::Analyzers::SimilarCommits do
  let(:config) { { 'min_edit_distance' => 4 } }
  subject(:analyzer) { described_class.new(config) }

  include_examples 'commit_analyzer'

  it 'has non-empty settings' do
    expect(analyzer.min_edit_distance).not_to be_nil
  end

  describe '#process_commit' do
    let(:old_commit) { fake_commit(message: old_commit_message) }
    let(:new_commit) do
      fake_commit(message: new_commit_message, parents: [old_commit])
    end

    subject(:result) { analyzer.process_commit(new_commit) }

    shared_examples 'offense result' do
      it 'returns one item' do
        expect(result).to have(1).item
      end

      describe 'returned item' do
        subject(:offense) { result.first }

        it 'is an offense' do
          expect(offense).to be_a(Repokeeper::Offenses::CommitOffense)
        end

        it 'has correct commit' do
          expect(offense.commit).to eq(new_commit)
        end

        it 'has message that references parent commint' do
          expect(offense.message).to include(old_commit.oid)
        end
      end
    end

    context 'when repeated commit messages' do
      let(:old_commit_message) { 'message' }
      let(:new_commit_message) { 'message' }

      include_examples 'offense result'
    end

    context 'when sequential similar commit messages' do
      let(:old_commit_message) { 'fix #1' }
      let(:new_commit_message) { 'fix #2' }

      include_examples 'offense result'
    end

    context 'when different commit messages' do
      let(:old_commit_message) { 'implemented a feature' }
      let(:new_commit_message) { 'major bug fixed' }

      it 'returns nothing' do
        expect(result).to have(0).items
      end
    end
  end
end

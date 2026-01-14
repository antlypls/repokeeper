require 'spec_helper'

describe Repokeeper::Offenses::CommitOffense do
  let(:commit) { fake_commit }

  subject(:offense) do
    described_class.new(commit, 'message', 'analyzer_name')
  end

  it 'has message attribute' do
    expect(offense.message).to eq('message')
  end

  it 'has commit attribute' do
    expect(offense.commit).to eq(commit)
  end

  it 'has analyzer_name attribute' do
    expect(offense.analyzer_name).to eq('analyzer_name')
  end
end

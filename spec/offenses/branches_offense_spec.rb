require 'spec_helper'

describe Repokeeper::Offenses::BranchesOffense do
  let(:branches) { %w(master feature) }

  subject(:offense) {
    described_class.new(branches, 'message', 'analyzer_name')
  }

  it 'has message attribute' do
    expect(offense.message).to eq('message')
  end

  it 'has branches attribute' do
    expect(offense.branches).to eq(branches)
  end

  it 'has analyzer_name attribute' do
    expect(offense.analyzer_name).to eq('analyzer_name')
  end
end

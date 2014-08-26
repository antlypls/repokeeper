require 'spec_helper'

describe Repokeeper::Analyzers::AnalyzersSet do
  subject { described_class.new }

  let(:commit_analyzer) { double(type: :commit) }
  let(:branch_analyzer) { double(type: :branch) }

  before(:each) do
    subject << commit_analyzer
    subject << branch_analyzer
  end

  describe '#commits_analyzers' do
    it 'filters commit analyzers' do
      expect(subject.commits_analyzers)
        .to match_array([commit_analyzer])
    end
  end

  describe '#branch_analyzers' do
    it 'filters branch analyzers' do
      expect(subject.branch_analyzers)
        .to match_array([branch_analyzer])
    end
  end
end

require 'spec_helper'

describe Repokeeper::Analyzers::Analyzer do
  subject { described_class.new({}) }

  it 'infers name' do
    expect(subject.name).to eq('Analyzer')
  end

  describe '#enabled' do
    subject { described_class.new(config).enabled? }

    context 'when config is empty' do
      let(:config) { {} }
      it 'is enabled' do
        is_expected.to eq(true)
      end
    end

    context 'when config has eneabled: true' do
      let(:config) { { 'enabled' => true } }
      it 'is enabled' do
        is_expected.to eq(true)
      end
    end

    context 'when config has eneabled: false' do
      let(:config) { { 'enabled' => false } }
      it 'is disabled' do
        is_expected.to eq(false)
      end
    end
  end

  describe '.all' do
    subject { described_class.all }

    it 'is an analyzers set' do
      is_expected.to be_a(Repokeeper::Analyzers::AnalyzersSet)
    end

    it 'contains all analyzers empty' do
      is_expected.to have(5).items
    end
  end
end

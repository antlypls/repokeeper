require 'spec_helper'

describe Repokeeper::RevParser do
  subject(:args_parser) { described_class.new(rev_spec) }

  before(:each) { args_parser.parse }

  context 'called with empty args list' do
    let(:rev_spec) { nil }

    it 'returns nil as a start_rev' do
      expect(args_parser.range.start_rev).to eq(nil)
    end

    it 'returns nil as a end_rev' do
      expect(args_parser.range.end_rev).to eq(nil)
    end
  end

  context 'called with end_rev only' do
    let(:rev_spec) { 'master' }

    it 'correctly parses end_rev' do
      expect(args_parser.range.end_rev).to eq('master')
    end

    it 'returns nil for end_rev' do
      expect(args_parser.range.start_rev).to eq(nil)
    end
  end

  context 'called with start_rev..end_rev' do
    let(:rev_spec) { 'head~4..head' }

    it 'correctly parses end_rev' do
      expect(args_parser.range.end_rev).to eq('head')
    end

    it 'correctly parses start_rev' do
      expect(args_parser.range.start_rev).to eq('head~4')
    end
  end
end

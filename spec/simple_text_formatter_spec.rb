require 'spec_helper'

describe Repokeeper::SimpleTextFormatter do
  let(:out_stream) { StringIO.new }
  let(:analyzer_name) { 'Dummy Analyzer' }
  subject(:formatter) { described_class.new(out_stream) }

  context 'commits analyzers' do
    let(:offenses) { nil }

    before(:each) do
      formatter.started
      formatter.commits_analyzer_results(analyzer_name, offenses)
      formatter.finished
    end

    it 'prints analyzer name' do
      expect(out_stream.string).to include(analyzer_name)
    end

    context 'with empty offenses list' do
      let(:offenses) { [] }
      it 'reports no issues' do
        expect(out_stream.string).to include('No issues')
      end
    end

    context 'with non-empty offenses list' do
      let(:fake_result) { fake_commit_results('analyzer message') }
      let(:offenses) { [fake_result] }

      it 'prints results' do
        expect(out_stream.string).to include(fake_result.message)
        expect(out_stream.string).to include(fake_result.commit.oid)
        expect(out_stream.string).to include(fake_result.commit.author[:name])
      end
    end
  end

  context 'branches analyzers' do
    let(:offenses) { nil }

    before(:each) do
      formatter.started
      formatter.branches_analyzer_results(analyzer_name, offenses)
      formatter.finished
    end

    it 'prints analyzer name' do
      expect(out_stream.string).to include(analyzer_name)
    end

    context 'with empty offenses list' do
      let(:offenses) { [] }
      it 'reports no issues' do
        expect(out_stream.string).to include('No issues')
      end
    end

    context 'with non-empty offenses list' do
      let(:fake_result) { fake_branches_results('analyzer message') }
      let(:offenses) { [fake_result] }

      it 'prints results' do
        expect(out_stream.string).to include(fake_result.message)
        expect(out_stream.string).to include(fake_result.branches.first)
        expect(out_stream.string).to include(fake_result.branches.last)
      end
    end
  end

  def fake_branches_results(message)
    result_class = Struct.new(:branches, :message, :analyzer_name)
    result_class.new(%w(master feature), message, analyzer_name)
  end

  def fake_commit_results(message)
    result_class = Struct.new(:commit, :message, :analyzer_name)
    result_class.new(fake_commit, message, analyzer_name)
  end
end

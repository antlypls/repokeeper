require 'spec_helper'

describe Repokeeper::RepoAnalyzer do
  let(:repo_proxy) { double('repo_proxy', commits: probe_commits) }
  let(:formatter) { double('formatter').as_null_object }
  let(:analyzers) { [dummy_analyzer] }
  let(:analyzers_set) { Repokeeper::Analyzers::AnalyzersSet.new(analyzers) }
  let(:config) { Repokeeper::Config.read }

  subject(:analyzer) {
    described_class.new(repo_proxy, formatter, analyzers_set, config)
  }

  context 'commits level analyzers' do
    let(:dummy_analyzer) { double('dummy_analyzer', type: :commit).as_null_object }
    let(:other_analyzer) { double('other_analyzer', type: :commit).as_null_object }

    let(:probe_commits) { [fake_commit] }

    describe '#analyze' do
      it 'passes rev_range to repo proxy' do
        range = Object.new

        expect(repo_proxy)
          .to receive(:commits).with(range).and_return([fake_commit])

        analyzer.analyze(range)
      end

      it 'analyzes repo' do
        expect(dummy_analyzer).to receive(:process_commit)
        analyzer.analyze
      end

      context 'multiple analyzers' do
        let(:analyzers) { [dummy_analyzer, other_analyzer] }

        it 'accepts multiple analyzers' do
          expect(dummy_analyzer).to receive(:process_commit)
          expect(other_analyzer).to receive(:process_commit)

          analyzer.analyze
        end
      end

      context 'multiple commits' do
        let(:probe_commits) { [1, 2, 3] }

        it 'sends commits to analyzer' do
          probe_commits.each do |commit|
            expect(dummy_analyzer).to receive(:process_commit).with(commit)
          end

          analyzer.analyze
        end
      end
    end

    context 'works with formatter' do
      it 'sends events to formatter in correct order' do
        expect(formatter).to receive(:started).with(no_args).ordered
        expect(formatter).to receive(:commits_analyzer_results).ordered
        expect(formatter).to receive(:finished).with(no_args).ordered

        analyzer.analyze
      end

      it 'sends analyzer name to formatter on finish' do
        expect(dummy_analyzer).to(
          receive(:name).with(no_args).and_return('dummy_analyzer').at_least(1).times
        )

        expect(formatter).to receive(:commits_analyzer_results).with('dummy_analyzer', anything)

        analyzer.analyze
      end

      it 'sends results to formatter on finish' do
        analyzis_result = ['dummy commit']
        expect(dummy_analyzer).to receive(:process_commit).and_return(analyzis_result)

        expect(formatter).to receive(:commits_analyzer_results).with(anything, analyzis_result)

        analyzer.analyze
      end
    end
  end

  context 'branches analyzers' do
    let(:probe_commits) { [] }
    let(:dummy_analyzer) { double('dummy_analyzer', type: :branch).as_null_object }
    let(:other_analyzer) { double('other_analyzer', type: :branch).as_null_object }

    it 'runs analyzers with repo proxy' do
      allow(repo_proxy).to receive(:commits).and_return([])
      expect(dummy_analyzer).to receive(:analyze).with(repo_proxy)
      analyzer.analyze
    end

    context 'multiple analyzers' do
      let(:analyzers) { [dummy_analyzer, other_analyzer] }

      it 'accepts multiple analyzers' do
        expect(dummy_analyzer).to receive(:analyze)
        expect(other_analyzer).to receive(:analyze)

        analyzer.analyze
      end
    end

    context 'works with formatter' do
      it 'sends events to formatter in correct order' do
        expect(formatter).to receive(:started).with(no_args).ordered
        expect(formatter).to receive(:branches_analyzer_results).ordered
        expect(formatter).to receive(:finished).with(no_args).ordered

        analyzer.analyze
      end

      it 'sends analyzer name to formatter on finish' do
        expect(dummy_analyzer)
          .to receive(:name).with(no_args)
          .and_return('dummy_analyzer')
          .at_least(1).times

        expect(formatter)
          .to receive(:branches_analyzer_results)
          .with('dummy_analyzer', anything)

        analyzer.analyze
      end

      it 'sends results to formatter on finish' do
        analyzis_result = Object.new

        expect(dummy_analyzer)
          .to receive(:analyze)
          .and_return(analyzis_result)

        expect(formatter)
          .to receive(:branches_analyzer_results)
          .with(anything, analyzis_result)

        analyzer.analyze
      end
    end
  end
end

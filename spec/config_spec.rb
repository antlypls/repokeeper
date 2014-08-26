require 'spec_helper'

describe Repokeeper::Config do
  let(:some_analyzer) do
    klass = Class.new
    def klass.name
      'Analyzers::SomeAnalyzer'
    end
    klass
  end

  describe '.default_configuration' do
    subject(:default_configuration) { described_class.default_configuration }

    it 'returns hash' do
      expect(default_configuration).to be_a(Hash)
    end

    it 'has correct configuration' do
      correct = {
        'local_branches_count' =>
          { 'max_local_branches' => 5 },
        'remote_branches_count' =>
          { 'max_remote_branches' => 5 },
        'merge_commits' => nil,
        'short_commit_message' =>
          { 'message_min_length' => 10 },
        'similar_commits' =>
          { 'min_edit_distance' => 4 }
      }

      expect(default_configuration).to eq(correct)
    end
  end

  describe '.read' do
    subject(:config) { described_class.read }

    it 'returns config class' do
      expect(config).to be_a(described_class)
    end
  end

  describe '.read(file_name)' do
    subject(:config) { described_class.read('.repokeeper.yml') }

    context 'with correct config file' do
      with_file '.repokeeper.yml', <<-EOF
        some_analyzer:
          some_setting: 1023
      EOF

      it 'reads config from file' do
        expect(config.for(some_analyzer)).to eq('some_setting' => 1023)
      end
    end

    context 'with config file with empty keys' do
      with_file '.repokeeper.yml', <<-EOF
        local_branches_count:
        remote_branches_count:
      EOF

      it 'uses default settings' do
        expect(config.for(Repokeeper::Analyzers::LocalBranchesCount)).to eq('max_local_branches' => 5)
        expect(config.for(Repokeeper::Analyzers::RemoteBranchesCount)).to eq('max_remote_branches' => 5)
      end
    end

    context 'config file overrides empty default' do
      with_file '.repokeeper.yml', <<-EOF
        merge_commits:
          enabled: false
      EOF

      it 'uses settings from file' do
        expect(config.for(Repokeeper::Analyzers::MergeCommits)).to eq('enabled' => false)
      end
    end
  end

  describe '#for' do
    let(:config_hash) { { 'some_analyzer' => { 'a' => 1 } } }
    let(:config) { described_class.new(config_hash) }
    subject(:config_for_analyzer) { config.for(some_analyzer) }

    it 'returns config hash class' do
      expect(config_for_analyzer).to be_a(Hash)
    end

    it 'returns hash for specific analyzer class' do
      expect(config_for_analyzer).to eq('a' => 1)
    end
  end
end

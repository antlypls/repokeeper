shared_examples 'commit_analyzer' do
  it 'returns coommits analyzer type' do
    expect(described_class.type).to eq(:commit)
  end

  it 'returns analyzer name' do
    expect(analyzer.name).to be_a(String)
    expect(analyzer.name).to_not be_empty
  end

  it 'accepts process_commit message' do
    expect { analyzer.process_commit(fake_commit) }.to_not raise_error
  end
end

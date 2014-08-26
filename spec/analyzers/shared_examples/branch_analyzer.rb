shared_examples 'branch_analyzer' do
  it 'returns branch type' do
    expect(described_class.type).to eq(:branch)
  end

  it 'returns branch name' do
    expect(analyzer.name).to_not be_empty
  end
end

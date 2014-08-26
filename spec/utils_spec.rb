require 'spec_helper'

describe Repokeeper::Utils do
  describe '.edit_distance' do
    it 'returns 0 for exact same strings' do
      expect(Repokeeper::Utils.edit_distance('same', 'same')).to eq(0)
    end

    it 'returns 1 for similar strings' do
      expect(Repokeeper::Utils.edit_distance('fix #1', 'fix #2')).to eq(1)
    end
  end
end

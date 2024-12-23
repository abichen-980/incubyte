require_relative '../assignment'

RSpec.describe '#add' do
  it 'checks existance' do
    expect(method(:add)).not_to be_nil
  end

  it 'accepts exactly one argument' do
    expect(method(:add).arity).to eq(1)
  end

  context 'checks functionality' do
    before do
      allow(self).to receive(:extract_numbers).and_return([1, 5])
    end

    it 'should return the sum of integers in a string' do
      expect(add('1,5')).to eq(6)
    end
  end
end

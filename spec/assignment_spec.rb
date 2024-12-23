require_relative '../assignment'

RSpec.describe '#add' do
  it 'checks existance' do
    expect(method(:add)).not_to be_nil
  end

  it 'accepts exactly one argument' do
    expect(method(:add).arity).to eq(1)
  end

  context 'checks functionality' do
    let(:test_input) { '1,5' }

    before do
      allow(self).to receive(:extract_numbers).and_return([1, 5])
    end

    it 'should return the sum of integers in a string' do
      expect(add(test_input)).to eq(6)
    end
  end

  context 'passing negative numbers' do
    let(:test_input) { '1,-5, -3' }

    before do
      allow(self).to receive(:extract_numbers).and_return([1, -5, -3])
    end

    it 'should throw an error' do
      expect { add(test_input) }.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
    end
  end

  context 'handling delimiter and string sanitisation' do
  end
end

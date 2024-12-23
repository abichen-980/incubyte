require_relative '../assignment'

RSpec.describe '#add' do
  it 'accepts exactly one argument' do
    expect(method(:add).arity).to eq(1)
  end

  context 'handling empty string' do
    let(:test_input) { '' }

    before do
      allow(self).to receive(:extract_numbers).and_return([])
    end

    it 'should throw an error' do
      expect(add(test_input)).to eq(0)
    end
  end

  context 'passing negative numbers' do
    let(:test_input) { '1,-5, -3' }

    before do
      allow(self).to receive(:extract_numbers).and_return([1, -5, -3])
    end

    it 'should throw an error(1)' do
      expect { add(test_input) }.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
    end
  end

  context 'handling real inputs' do
    context 'without delimter' do
      it 'simple string should calculate sum and return 9' do
        expect(add('1, 5, 3')).to eq(9)
      end

      it 'string with newline should calculate sum and return 9' do
        expect(add("\n1, \n5, \n\n3")).to eq(9)
      end

      it 'string with newtab should calculate sum and return 9' do
        expect(add("\t1, \t5, \t\t3")).to eq(9)
      end

      it 'string with alphabets should calculate sum and return 9' do
        expect(add('a1, b5, c3')).to eq(9)
      end

      it 'string with special characters should calculate sum and return 9' do
        expect(add('#1, %^5, &!3')).to eq(9)
      end

      it 'string with newline, newtab, alphabets, special charecters should calculate sum and return 9' do
        expect(add('\n1, \t5, &!b3')).to eq(9)
      end
    end
  end
end

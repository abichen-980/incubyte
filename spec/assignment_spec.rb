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

    it 'should return 0' do
      expect(add(test_input)).to eq(0)
    end
  end

  context 'receiving negative numbers' do
    let(:test_input) { '1,-5, -3' }

    before do
      allow(self).to receive(:extract_numbers).and_return([1, -5, -3])
    end

    it 'should throw an error' do
      expect { add(test_input) }.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
    end
  end

  context 'recieving input' do
    context 'without delimter' do
      it 'should calculate sum for simple string' do
        expect(add('1, 5, 3')).to eq(9)
      end

      it 'should calculate sum for string with newlines' do
        expect(add("\n1, \n5, \n\n3")).to eq(9)
      end

      it 'should calculate sum for string with newtabs' do
        expect(add("\t1, \t5, \t\t3")).to eq(9)
      end

      it 'should calculate sum for string with alphabets' do
        expect(add('a1, b5, c3')).to eq(9)
      end

      it 'should calculate sum for string with special characters' do
        expect(add('#1, %^5, &!3')).to eq(9)
      end

      it 'should calculate sum for string with newlines, newtabs, alphabets, special characters' do
        expect(add('\n1, \t5, &!b3')).to eq(9)
      end

      it 'should raise error for string with negative numbers' do
        expect { add('\n1, \t-5, &!b-3') }.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
      end

      it 'should calculate sum for string with multiple delimters' do
        expect(add('\n1,,,\t5, &!b3')).to eq(9)
      end
    end

    context 'with delimter (;)' do
      it 'should calculate sum for simple string' do
        expect(add('//;1; 5; 3')).to eq(9)
      end

      it 'should calculate sum for string with newlines' do
        expect(add("//;\n1; \n5; \n\n3")).to eq(9)
      end

      it 'should calculate sum for string with newtabs' do
        expect(add("//;\t1; \t5; \t\t3")).to eq(9)
      end

      it 'should calculate sum for string with alphabets' do
        expect(add('//;a1; b5; c3')).to eq(9)
      end

      it 'should calculate sum for string with special characters' do
        expect(add('//;#1; %^5; &!3')).to eq(9)
      end

      it 'should calculate sum for string with newlines, newtabs, alphabets, special characters' do
        expect(add("//;\n1; \t5; &!b3")).to eq(9)
      end

      it 'should raise error for string with negative numbers' do
        expect do
          add("//;\n1; \t-5; &!b-3")
        end.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
      end

      it 'should calculate sum for string with multiple delimters' do
        expect(add("//;\n1;;;\t5; &!b3")).to eq(9)
      end

      it 'should calculate sum for string with default delimter' do
        expect(add("//;\,,,,n1;;;\t5; &!b3")).to eq(9)
      end

      it 'should calculate sum for string with empty spaces' do
        expect(add("//;\     ,n   1;;;\t5; &!b3")).to eq(9)
      end
    end
  end
end

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

  shared_context 'generic context' do
    it 'returns 0 for a string with only delimiters' do
      expect(add(',,,,')).to eq(10)
    end

    it 'returns 0 for an empty string' do
      expect(add('')).to eq(0)
    end

    it 'returns 0 for a string with only non-default delimiters' do
      expect(add('//;;^^^^!;;;')).to eq(0)
    end

    it 'returns 0 for a string with no integers' do
      expect(add(';;;xadada()!,-+;;')).to eq(0)
    end
  end

  context 'recieving a string paramater' do
    context 'with default delimiter' do
      context 'should calculate the sum of integers in' do
        it 'a simple string' do
          expect(add('1, 5, 3')).to eq(9)
        end

        it 'a string with spaces at begining/end' do
          expect(add('  //,1, 5, 3  ')).to eq(9)
        end

        it 'a string with newlines' do
          expect(add("\n1, \n5, \n\n3")).to eq(9)
        end

        it 'a string with newtabs' do
          expect(add("\t1, \t5, \t\t3")).to eq(9)
        end

        it 'a string with alphabets' do
          expect(add('a1, b5, c3')).to eq(9)
        end

        it 'a with special characters' do
          expect(add('#1, %^5, &!3')).to eq(9)
        end

        it 'a with newlines, newtabs, alphabets, special characters' do
          expect(add('\n1, \t5, &!b3')).to eq(9)
        end

        it 'a with multiple delimters' do
          expect(add('\n1,,,\t5, &!b3')).to eq(9)
        end
      end

      context 'should raise error for' do
        it 'a string with only negative numbers' do
          expect { add('-1, -5, -3') }.to raise_error(NegativeNumbersError, /negative numbers not allowed -1, -5, -3/)
        end

        it 'a string with some negative numbers' do
          expect { add('\n1, \t-5, &!b-3') }.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
        end
      end

      include_context 'generic context'
    end

    context 'with a delimter (;)' do
      context 'should calculate the sum of integers in' do
        it 'a simple string' do
          expect(add('//;1; 5; 3')).to eq(9)
        end

        it 'in a string with space at begining/end' do
          expect(add('  //;1; 5; 3  ')).to eq(9)
        end

        it 'in a string with newlines' do
          expect(add("//;\n1; \n5; \n\n3")).to eq(9)
        end

        it 'in a string with newtabs' do
          expect(add("//;\t1; \t5; \t\t3")).to eq(9)
        end

        it 'in a string with alphabets' do
          expect(add('//;a1; b5; c3')).to eq(9)
        end

        it 'a string with special characters' do
          expect(add('//;#1; %^5; &!3')).to eq(9)
        end

        it 'a string with newlines, newtabs, alphabets, special characters' do
          expect(add("//;\n1; \t5; &!b3")).to eq(9)
        end

        it 'a string with multiple delimters' do
          expect(add("//;\n1;;;\t5; &!b3")).to eq(9)
        end

        it 'a string with default delimter' do
          expect(add("//;\,,,,n1;;;\t5; &!b3")).to eq(9)
        end

        it 'in a string with empty spaces' do
          expect(add("//;\     ,n   1;;;\t5; &!b3")).to eq(9)
        end
      end

      context 'should raise error for' do
        it 'a string with negative numbers' do
          expect do
            add("//;\n1; \t-5; &!b-3")
          end.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
        end

        it 'a string with only negative numbers' do
          expect do
            add('//;-1; -5; -3')
          end.to raise_error(NegativeNumbersError, /negative numbers not allowed -1, -5, -3/)
        end
      end

      include_context 'generic context'
    end
  end
end

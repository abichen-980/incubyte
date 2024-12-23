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
      expect do
        add('1,-5,-3')
      end.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
    end
  end

  shared_context 'functionality_tests' do
    context 'should calculate the sum of integers in' do
      it 'a simple string' do
        expect(add(input_variants[:simple])).to eq(9)
      end

      it 'a string with spaces at begining/end' do
        expect(add(input_variants[:space])).to eq(9)
      end

      it 'a string with newlines' do
        expect(add(input_variants[:new_lines])).to eq(9)
      end

      it 'a string with newtabs' do
        expect(add(input_variants[:new_tabs])).to eq(9)
      end

      it 'a string with alphabets' do
        expect(add(input_variants[:alphabets])).to eq(9)
      end

      it 'a with special characters' do
        expect(add(input_variants[:specials])).to eq(9)
      end

      it 'a with newlines, newtabs, alphabets, special characters' do
        expect(add(input_variants[:all])).to eq(9)
      end

      it 'a with multiple delimiters' do
        expect(add(input_variants[:multiples])).to eq(9)
      end

      it 'a with only delimiters' do
        expect(add(input_variants[:only_delimiters])).to eq(0)
      end
    end

    context 'should raise error for' do
      it 'a string with only negative numbers' do
        expect do
          add(input_variants[:negatives_only])
        end.to raise_error(NegativeNumbersError, /negative numbers not allowed -1, -5, -3/)
      end

      it 'a string with some negative numbers' do
        expect do
          add(input_variants[:some_negatives])
        end.to raise_error(NegativeNumbersError, /negative numbers not allowed -5, -3/)
      end
    end
  end

  shared_context 'generic_context' do
    it 'returns 0 for an empty string' do
      expect(add('')).to eq(0)
    end

    it 'returns 0 for a string with no integers' do
      expect(add(';;;xadada()!,-+;;')).to eq(0)
    end
  end

  context 'recieving a string paramater' do
    context 'with default delimiter' do
      let(:input_variants) do
        {
          simple: '1, 5, 3',
          space: '  //,1, 5, 3  ',
          new_lines: "\n1, \n5, \n\n3",
          new_tabs: "\t1, \t5, \t\t3",
          alphabets: 'a1, b5, c3',
          specials: '#1, %^5, &!3',
          all: "\n1, \t5, &!b3",
          multiples: "\n1,,,\t5, &!b3",
          negatives_only: '-1, -5, -3',
          some_negatives: "\n1, \t-5, &!b-3",
          only_delimiters: ',,,,,,,,,, ,,,'
        }
      end

      include_context 'functionality_tests'
      include_context 'generic_context'
    end

    context 'with delimiter (;)' do
      let(:input_variants) do
        {
          simple: '//;1; 5; 3',
          space: '  //;1; 5; 3  ',
          new_lines: "//;\n1; \n5; \n\n3",
          new_tabs: "//;\t1; \t5; \t\t3",
          alphabets: '//;a1; b5; c3',
          specials: '//;#1; %^5; &!3',
          all: "//;\n1; \t5; &!b3",
          multiples: "//;\n1;;;\t5; &!b3",
          negatives_only: '//;-1; -5; -3',
          some_negatives: "//;\n1; \t-5; &!b-3",
          only_delimiters: '//;//;;;;;;;;;;'
        }
      end

      include_context 'functionality_tests'
      include_context 'generic_context'
    end
  end
end

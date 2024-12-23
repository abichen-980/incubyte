# frozen_string_literal: true

# passing negative numbers should throw an error with negative numbers passed.
class NegativeNumbersError < StandardError
end

def add(input_string)
  input_string = input_string.to_s
  numbers = extract_numbers(input_string)
  negatives = numbers.select(&:negative?)
  raise NegativeNumbersError, "negative numbers not allowed #{negatives.join(', ')}" unless negatives.empty?

  numbers.sum
end

private

def extract_numbers(input_string)
  input_string.to_s
end

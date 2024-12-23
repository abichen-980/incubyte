# frozen_string_literal: true

# passing negative numbers should throw an error with negative numbers passed.
class NegativeNumbersError < StandardError
end

def add(input_string)
  input_string = input_string.to_s
  numbers = extract_numbers(input_string)
  return 0 if numbers.empty?

  validate_and_sum_numbers(numbers)
end

private

def validate_and_sum_numbers(numbers)
  numbers_sum = 0
  negatives = []

  numbers.each do |num|
    negatives << num if num.negative?
    next unless negatives.empty?

    numbers_sum += num
  end

  raise NegativeNumbersError, "negative numbers not allowed #{negatives.join(', ')}" unless negatives.empty?

  numbers_sum
end

def extract_numbers(input_string)
  input_string.to_s
end

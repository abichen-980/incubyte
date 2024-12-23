require 'byebug'
# frozen_string_literal: true

# passing negative numbers should throw an error with negative numbers passed.
class NegativeNumbersError < StandardError
end

def add(input_string)
  input_string = input_string.to_s.strip
  numbers = extract_numbers(input_string)
  return 0 if numbers.empty?

  validate_and_calculate_sum(numbers)
end

private

def validate_and_calculate_sum(numbers)
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
  delimiter = determine_delimiter(input_string)
  sanitized_input = sanitize_with_delimiter(input_string, delimiter)
  sanitized_input.split(delimiter).map(&:to_i)
end

def sanitize_with_delimiter(input_string, delimiter)
  input_string.gsub(/\\n|\\t/, ' ').gsub(/[^0-9#{Regexp.escape(delimiter)}-]/, '')
end

# currently it handles only one character delimiter
def determine_delimiter(input_string)
  input_string.start_with?('//') ? input_string[2] : ','
end

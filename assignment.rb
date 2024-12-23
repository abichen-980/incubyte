def add(input_string)
  input_string = input_string.to_s
  numbers = extract_numbers(input_string)
  sum = 0
  numbers.each do |number|
    sum += number
  end
  sum
end

private

def extract_numbers(input_string)
  input_string.to_s
end
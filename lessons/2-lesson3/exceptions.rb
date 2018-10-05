# RETRY_LIMIT = 5
#
# begin
#   attempts ||= 0
#   puts 1/0
# rescue StandardError => e
#   attempts += 1
#   puts e.message, e.class
#   puts "Failed #{attempts} times, retrying......"
#   retry if attempts < 5
# end

class ValidateAgeError < Exception
end

def validate_age(age)
  raise(ValidateAgeError, "Invalid age: #{age}") unless (1..105).include?(age)
end

begin
  validate_age(199)
rescue ValidateAgeError => e
  puts e.message
  puts e.class
end

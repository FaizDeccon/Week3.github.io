# frozen_string_literal: true

print 'Choose your password length(8-16): '
while (p_length = gets.chomp.to_i)
  break if p_length.between?(8, 16)

  puts 'Invaid Input! Try again'
  print 'Choose your password length(8-16): '
end
print 'Do you want alphabets in your password(Y/N): '
while (alphabets = gets.chomp)
  break if %w[Y N].include?(alphabets)

  puts 'Invaid Input! Try again'
  print 'Do you want alphabets in your password(Y/N): '
end
print 'Do you want numbers in your password(Y/N): '
while (numbers = gets.chomp)
  break if %w[Y N].include?(numbers)

  puts 'Invaid Input! Try again'
  print 'Do you want numbers in your password(Y/N): '
end
print 'Do you want any special-characters in your password(Y/N): '
while (s_characters = gets.chomp)
  break if %w[Y N].include?(s_characters)

  puts 'Invaid Input! Try again'
  print 'Do you want special-characters in your password(Y/N): '
end
if alphabets == 'Y' && numbers == 'Y' && s_characters == 'Y'
  pass = Array.new(p_length / 4) { ('a'..'z').to_a[rand(26)] + ('A'..'Z').to_a[rand(26)] + ('0'..'9').to_a[rand(10)] + rand(33..47).chr }.join
  (p_length - pass.length).times { pass << ('0'..'9').to_a[rand(10)] }
elsif alphabets == 'Y' && numbers == 'N' && s_characters == 'Y'
  pass = Array.new(p_length / 3) { ('a'..'z').to_a[rand(26)] + ('A'..'Z').to_a[rand(26)] + rand(33..47).chr }.join
  (p_length - pass.length).times { pass << rand(33..47).chr }
elsif alphabets == 'Y' && numbers == 'Y' && s_characters == 'N'
  pass = Array.new(p_length / 3) { ('a'..'z').to_a[rand(26)] + ('A'..'Z').to_a[rand(26)] + ('0'..'9').to_a[rand(10)] }.join
  (p_length - pass.length).times { pass << ('0'..'9').to_a[rand(10)] }
elsif alphabets == 'Y' && numbers == 'N' && s_characters == 'N'
  pass = Array.new(p_length / 2) { ('a'..'z').to_a[rand(26)] + ('A'..'Z').to_a[rand(26)] }.join
  (p_length - pass.length).times { pass << ('a'..'z').to_a[rand(26)] }
elsif alphabets == 'N' && numbers == 'Y' && s_characters == 'Y'
  pass = Array.new(p_length / 2) { ('0'..'9').to_a[rand(10)] + rand(33..47).chr }.join
  (p_length - pass.length).times { pass << rand(33..47).chr }
elsif alphabets == 'N' && numbers == 'N' && s_characters == 'Y'
  pass = Array.new(p_length) { rand(33..47).chr }.join
  (p_length - pass.length).times { pass << rand(33..47).chr }
elsif alphabets == 'N' && numbers == 'Y' && s_characters == 'N'
  pass = Array.new(p_length) { ('0'..'9').to_a[rand(10)] }.join
  (p_length - pass.length).times { pass << ('0'..'9').to_a[rand(10)] }
else
  puts 'All three fields cannot be empty'
  exit
end
puts "Your password: #{pass}"

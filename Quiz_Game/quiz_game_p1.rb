# frozen_string_literal: true

require 'csv'
filename = 'problems.csv'
filename = "#{ARGV[1]}.csv" if ARGV[0] == 'filename'
ARGV.clear
questions = CSV.read(filename)
count = 0
puts '***Welcom to the Quiz***'
questions.length.times do |x|
  puts "Question #{x + 1}: #{questions[x][0]}"
  if questions[x][1] == gets.chomp.strip
    count += 1
    puts 'Correct Answer!'
  else
    puts 'Wrong Answer!'
  end
end
puts '**********RESULT**********'
puts "Total Questions: #{questions.length}"
puts "Questions Answered Correctly: #{count}"

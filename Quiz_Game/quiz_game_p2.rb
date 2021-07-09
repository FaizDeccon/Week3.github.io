# frozen_string_literal: true

require 'csv'
require 'timeout'
questions = CSV.read('problems.csv')
count = 0
time = 30
print 'Enter Y if you want to change the timer or any other key if you do not: '
if gets.chomp == 'Y'
  print 'Enter time for the quiz: '
  time = gets.chomp.to_i
end
print 'Enter Y to shuffle the questions or any other key to start the quiz: '
questions.shuffle! if gets.chomp == 'Y'
puts '***Quiz Started***'
Timeout.timeout(time, Timeout::Error) do
  puts "Time: #{time} seconds"
  questions.length.times do |x|
    puts "Question #{x + 1}: #{questions[x][0]}"
    if questions[x][1] == gets.chomp.strip
      count += 1
      puts 'Correct Answer!'
    else
      puts 'Wrong Answer!'
    end
  end
rescue Timeout::Error
  puts '*****Time Out!*****'
end
puts '**********RESULT**********'
puts "Total Questions: #{questions.length}"
puts "Questions Answered Correctly: #{count}"

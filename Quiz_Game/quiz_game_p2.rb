# frozen_string_literal: true

require 'csv'
require 'timeout'
filename = 'problems.csv'
filename = "#{ARGV[1]}.csv" if ARGV[0] == 'filename'
questions = CSV.read(filename)
count = 0
time = 30
time = ARGV[3].to_i if ARGV[2] == 'time'
time = ARGV[1].to_i if ARGV[0] == 'time'
questions.shuffle! if ARGV[4] == 'shuffle' || ARGV[0] == 'shuffle' || ARGV[2] == 'shuffle'
ARGV.clear
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

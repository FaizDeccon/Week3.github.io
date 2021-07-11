# frozen_string_literal: true

module Year
  @values = [0, -1000, 1000, -1000, '', '', '']
  @month = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  @months = Hash['1' => 'January', '2' => 'Febuary', '3' => 'March', '4' => 'April',
                 '5' => 'May', '6' => 'June', '7' => 'July', '8' => 'August',
                 '9' => 'September', '10' => 'October', '11' => 'November', '12' => 'December']
  def print_max_temp
    puts "Highest: #{@values[1]}C on #{@months[@values[4].split('-')[1]]} #{@values[4].split('-')[2]}"
  end

  def print_min_temp
    puts "Lowest: #{@values[2]}C on #{@months[@values[5].split('-')[1]]} #{@values[5].split('-')[2]}"
  end

  def print_max_humid
    puts "Humid: #{@values[3]}% on #{@months[@values[6].split('-')[1]]} #{@values[6].split('-')[2]}"
  end

  def print_year_data
    if @values[0].positive?
      print_max_temp
      print_min_temp
      print_max_humid
    else
      puts 'No data found for the given year!'
    end
  end

  def compare_max(line, num1, num2)
    return unless line.split(',')[num2].to_i > @values[num1]

    @values[num1] = line.split(',')[num2].to_i
    @values[num1 + 3] = line.split(',')[0]
  end

  def compare_min(line, num1, num2)
    return unless line.split(',')[num2].to_i < @values[num1] && line.split(',')[num2] != ''

    @values[num1] = line.split(',')[num2].to_i
    @values[num1 + 3] = line.split(',')[0]
  end

  def year_func(folderpath, filename)
    @month.each do |m|
      filepath = "#{folderpath}/#{filename}#{m}.txt"
      next unless File.exist?(filepath)

      file = File.open(filepath, 'r')
      file.readlines.drop(1).each do |line|
        compare_max(line, 1, 1)
        compare_min(line, 2, 3)
        compare_max(line, 3, 7)
        @values[0] += 1
      end
    end
    print_year_data
  end
end

module Month
  @values_mon = [0, 0, 0, 0, 0, 0]
  @months = Hash['1' => 'January', '2' => 'Febuary', '3' => 'March', '4' => 'April',
                 '5' => 'May', '6' => 'June', '7' => 'July', '8' => 'August',
                 '9' => 'September', '10' => 'October', '11' => 'November', '12' => 'December']
  @month_names = Hash['1' => 'Jan', '2' => 'Feb', '3' => 'Mar', '4' => 'Apr',
                      '5' => 'May', '6' => 'Jun', '7' => 'Jul', '8' => 'Aug',
                      '9' => 'Sep', '10' => 'Oct', '11' => 'Nov', '12' => 'Dec']
  def print_month_data
    puts "Highest Average: #{@values_mon[3] / @values_mon[0]}C"
    puts "Lowest Average: #{@values_mon[4] / @values_mon[1]}C"
    puts "Average Humidity: #{@values_mon[5] / @values_mon[2]}%"
  end

  def print_red_lines(line)
    print "#{line.split(',')[0].split('-')[2]} "
    line.split(',')[1].to_i.times do
      print '+'.red
    end
    puts " #{line.split(',')[1]}C"
  end

  def print_blue_lines(line)
    print "#{line.split(',')[0].split('-')[2]} "
    line.split(',')[3].to_i.times do
      print '+'.blue
    end
    puts " #{line.split(',')[3]}C"
  end

  def print_multi_lines(line)
    print "#{line.split(',')[0].split('-')[2]} "
    print_blue(line)
    print_red(line)
    puts " #{line.split(',')[3]}C - #{line.split(',')[1]}C"
  end

  def print_blue(line)
    line.split(',')[3].to_i.times do
      print '+'.blue
    end
  end

  def print_red(line)
    line.split(',')[1].to_i.times do
      print '+'.red
    end
  end

  def set_month_data(line, num1, num2)
    return unless line.split(',')[num2] != ''

    @values_mon[num1 + 3] += line.split(',')[num2].to_i
    @values_mon[num1] += 1
  end

  def mon_func(folderpath, filename, monthnum)
    filepath = "#{folderpath}/#{filename}#{@month_names[monthnum]}.txt"
    if File.exist?(filepath)
      File.readlines(filepath).drop(1).each do |line|
        set_month_data(line, 0, 1)
        set_month_data(line, 1, 3)
        set_month_data(line, 2, 7)
      end
      print_month_data
    else
      puts 'No data found for the given month!'
    end
  end

  def print_lines(folderpath, filename, year, monthnum)
    filepath = "#{folderpath}/#{filename}#{@month_names[monthnum]}.txt"
    if File.exist?(filepath)
      puts "#{@months[monthnum]} #{year}"
      File.readlines(filepath).drop(1).each do |line|
        print_red_lines(line) if line.split(',')[1] != ''
        print_blue_lines(line) if line.split(',')[3] != ''
      end
    else
      puts 'No data found for the given month!'
    end
  end

  def print_bonus(folderpath, filename, year, monthnum)
    filepath = "#{folderpath}/#{filename}#{@month_names[monthnum]}.txt"
    if File.exist?(filepath)
      puts "#{@months[monthnum]} #{year}"
      File.readlines(filepath).drop(1).each do |line|
        print_multi_lines(line) if line.split(',')[1] != '' || line.split(',')[3] != ''
      end
    else
      puts 'No data found for the given month!'
    end
  end
end

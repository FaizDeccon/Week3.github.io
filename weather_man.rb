# frozen_string_literal: true

require 'colorize'
require_relative 'data_functions'
Object.include(Tools)
filename = "#{ARGV[2].split('/')[-1]}_#{ARGV[1].split('/')[0]}_"
Tools.year_func(ARGV[2], filename) if ARGV[0] == '-e'
monthnum = ARGV[1].split('/')[-1].to_i.to_s
Tools.mon_func(ARGV[2], filename, monthnum) if ARGV[0] == '-a'
year = ARGV[1].split('/')[0]
Tools.print_lines(ARGV[2], filename, year, monthnum) if ARGV[0] == '-c' && ARGV[1].split('/')[-1].to_s[0] != '0'
Tools.print_bonus(ARGV[2], filename, year, monthnum) if ARGV[0] == '-c' && ARGV[1].split('/')[-1].to_s[0] == '0'

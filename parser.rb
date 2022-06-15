#!/usr/bin/ruby
# frozen_string_literal: true

require './log_printer'
require './log_table_printer'

class Parser
  attr_reader :file_name, :log_printer

  def initialize(file_name, log_printer: LogPrinter, log_processor: LogProcessor)
    @file_name = file_name
    @log_processor = log_processor.new(file_name)
    @log_printer = log_printer.new(@log_processor)
  end

  def run
    return expected_command_hint unless file_name_correct?


    log_printer.print_aggregate
  end

  private

  def file_name_correct?
    file_name == 'links.log'
  end

  def expected_command_hint
    puts 'The right usage is: ./parser.rb links.log'
  end
end

if $0 == __FILE__
  case ARGV[1]
  when '--table'
    puts Parser.new(ARGV.first, log_printer: LogTablePrinter).run
  else
    puts Parser.new(ARGV.first).run
  end
end


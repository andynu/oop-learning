#!/usr/bin/ruby
# frozen_string_literal: true

require './log_printer'

class Parser
  attr_reader :file_name

  def initialize(file_name, log_printer: LogPrinter::List, log_processor: LogProcessor)
    @file_name = file_name
    @log_processor_class = log_processor
    @log_printer_class = log_printer
  end

  def run
    return expected_command_hint unless file_name_correct?

    aggregated_data = @log_processor_class.new(file_name).process
    log_printer = @log_printer_class.new(aggregated_data)
    log_printer
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
    puts Parser.new(ARGV.first, log_printer: LogPrinter::Table).run
  else
    puts Parser.new(ARGV.first).run
  end
end


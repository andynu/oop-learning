#!/usr/bin/ruby
# frozen_string_literal: true

require './log_printer'
require 'pry'
class Parser
  attr_reader :file_name, :log_printer

  def initialize(file_name, log_printer: LogPrinter.new(file_name))
    @file_name = file_name
    @log_printer = log_printer
  end

  def parser_result
    return expected_command_hint unless file_name_correct?

    log_printer.print_aggregate
  end

  private

  def file_name_correct?
    file_name == 'links.log'
  end

  def expected_command_hint
    puts 'The right usage is: ./parser.rb webserver.log'
  end
end

Parser.new(ARGV.first).parser_result
# Parser.new(ARGV.first)


#!/usr/bin/ruby
# frozen_string_literal: true

class LogProcessor
  attr_accessor :log_file, :log_statistics
  attr_reader :page_views, :unique_page_views

  def initialize(file_name)
    @file_name = file_name
  end

  def process
    @log_file = File.read(@file_name)
    @log_statistics = Hash.new { |h, k| h[k] = [] } # auto vivifying array values.
    log_file.each_line do |line|
      path, ip = line.split(' ')
      log_statistics[path] << ip
    end
    @page_views = hash_sort_decending log_statistics.transform_values(&:count)
    @unique_page_views = hash_sort_decending log_statistics.transform_values {|ips| ips.uniq.count }
    self
  end

  private

  def hash_sort_decending(hash)
    hash.sort_by { |_, value| value }.reverse
  end
end

# rescue FileReadError => e
#   e.message
# class FileReadError < StandardError
# end
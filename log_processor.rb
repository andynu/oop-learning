#!/usr/bin/ruby
# frozen_string_literal: true

class LogProcessor
  attr_accessor :log_file, :log_statistics

  def initialize(file_name)
    return unless file_name == 'links.log'

    self.log_file = File.read(file_name)
    self.log_statistics = Hash.new { |h, k| h[k] = [] } # auto vivifying array values.
    process_log_file
  end

  def process_log_file
    log_file.each_line do |line|
      path, ip = line.split(' ')
      log_statistics[path] << ip
    end
  end

  def page_views
    hash_sort_decending log_statistics.transform_values(&:count)
  end

  def unique_page_views
    hash_sort_decending log_statistics.transform_values {|ips| ips.uniq.count }
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
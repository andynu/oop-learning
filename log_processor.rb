#!/usr/bin/ruby
# frozen_string_literal: true

class LogProcessor
  attr_accessor :log_file, :log_statistics

  def initialize(file_name)
    return unless file_name == 'links.log'

    self.log_file = File.read(file_name)
    self.log_statistics = {}
    process_log_file
  end

  def process_log_file
    log_file.each_line do |line|
      path, ip = line.split(' ')
      log_statistics.key?(path) ? log_statistics[path] << ip : log_statistics[path] = [ip]
    end
  end

  def page_views
    result = log_statistics.each_with_object({}) { |(path, ips), hash| hash[path] = ips.count }
    result.sort_by { |_path, count| count }.reverse
  end

  def unique_page_views
    result = log_statistics.each_with_object({}) { |(path, ips), hash| hash[path] = ips.uniq.count }
    result.sort_by { |_path, count| count }.reverse
  end
end

# rescue FileReadError => e
#   e.message
# class FileReadError < StandardError
# end
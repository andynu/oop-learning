#!/usr/bin/ruby
# frozen_string_literal: true

class LogProcessor
  attr_reader :page_views, :unique_page_views

  LogEvent = Struct.new(:path, :ip)

  def initialize(file_name)
    @file_name = file_name
  end

  def process
    log_events = File.readlines(@file_name).map { |line| LogEvent.new(*line.split) }
    log_statistics = log_events.group_by(&:path).transform_values{ |events| events.map(&:ip) }

    @page_views = hash_sort_decending log_statistics.transform_values(&:count)
    @unique_page_views = hash_sort_decending log_statistics.transform_values { |ips| ips.uniq.count }
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
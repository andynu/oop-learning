#!/usr/bin/ruby
# frozen_string_literal: true

require 'ostruct'

class LogProcessor
  attr_reader :page_views, :unique_page_views

  LogEvent = Struct.new(:path, :ip)

  def initialize(file_name)
    @file_name = file_name
  end

  def process
    log_events = File.readlines(@file_name).map { |line| LogEvent.new(*line.split) }
    log_statistics = log_events.group_by(&:path).transform_values{ |events| 
      ips = events.map(&:ip) 
      OpenStruct.new(
        page_views: ips.count,
        unique_page_views: ips.uniq.count
      )
    }

    reverse_sort = lambda {|(k, v)| v }

    OpenStruct.new(
      page_views: log_statistics.transform_values(&:page_views).sort_by(&reverse_sort).reverse,
      unique_page_views: log_statistics.transform_values(&:unique_page_views).sort_by(&reverse_sort).reverse
    )
  end

end

# rescue FileReadError => e
#   e.message
# class FileReadError < StandardError
# end
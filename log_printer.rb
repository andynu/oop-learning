#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor'

class LogPrinter
  attr_accessor :file_name, :log_processor

  def initialize(file_name, log_processor: LogProcessor.new(file_name))
    @file_name = file_name
    @log_processor = log_processor
  end

  # def call(file_name)
  #   new(file_name).print_aggregate
  # end

  def print_aggregate
    puts aggregator
  end

  def aggregator
    ['WEBPAGES WITH MOST PAGE VIEWS:', most_page_views,
     'WEBPAGES WITH MOST UNIQUE PAGE VIEWS:', most_unique_page_views].join("\n")
  end

  def most_page_views
    page_views = log_processor.page_views
    page_views.map { |path, ip_count| "#{path} - #{ip_count} visits" }.join("\n")
  end

  def most_unique_page_views
    unique_views = log_processor.unique_page_views
    unique_views.map { |path, uniq_ips| "#{path} - #{uniq_ips} unique views" }.join("\n")
  end
end

#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor'

class LogTablePrinter
  attr_accessor :log_processor

  def initialize(log_processor)
    @log_processor = log_processor
  end

  def print_aggregate
    aggregator
  end

  def aggregator
    ['WEBPAGES WITH MOST PAGE VIEWS:', most_page_views,
     'WEBPAGES WITH MOST UNIQUE PAGE VIEWS:', most_unique_page_views].join("\n\n")
  end

  def most_page_views
    page_views = log_processor.page_views
    page_views.map { |path, ip_count| "|%20s|%10s visits|" % [path, ip_count] }.join("\n")
  end

  def most_unique_page_views
    unique_views = log_processor.unique_page_views
    unique_views.map { |path, uniq_ips| "|%20s|%10s uniq views|" % [path, uniq_ips] }.join("\n")
  end
end

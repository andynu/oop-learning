#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor'

class LogPrinter
  attr_accessor :log_processor

  def initialize(log_processor)
    @log_processor = log_processor
  end

  def to_s
    [
      'WEBPAGES WITH MOST PAGE VIEWS:',
      most_page_views,
      'WEBPAGES WITH MOST UNIQUE PAGE VIEWS:',
      most_unique_page_views
    ].join("\n")
  end

  private

  def most_page_views
    fmt_hash log_processor.page_views, 'visits'
  end

  def most_unique_page_views
    fmt_hash log_processor.unique_page_views, 'unique views'
  end

  def fmt_hash(hash, count_label)
    hash.map { |key, value| "#{key} - #{value} #{count_label}" }.join("\n")
  end
end

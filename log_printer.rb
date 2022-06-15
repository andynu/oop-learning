#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor'

class LogPrinter
  attr_accessor :page_stats

  def initialize(page_stats)
    @page_stats = page_stats
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
    page_views = page_stats.transform_values(&:page_views).sort_by(&pair_arr_sort).reverse
    fmt_hash page_views, 'visits'
  end

  def most_unique_page_views
    unique_page_views = page_stats.transform_values(&:unique_page_views).sort_by(&pair_arr_sort).reverse
    fmt_hash unique_page_views, 'unique views'
  end

  def fmt_hash(hash, count_label)
    hash.map { |key, value| "#{key} - #{value} #{count_label}" }.join("\n")
  end

  def pair_arr_sort 
    lambda {|(k, v)| v }
  end


end

#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor'

class LogTablePrinter
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
    ].join("\n\n")
  end

  private

  def most_page_views
    fmt_table :page_views, 'visits'
  end

  def most_unique_page_views
    fmt_table :unique_page_views, 'uniq views'
  end

  def fmt_table(key, value_label)
    hash = page_stats.transform_values{|stats| stats.send(key)}.sort_by(&pair_arr_sort).reverse
    key_max_size = hash.to_h.keys.map(&:size).max
    value_max_size = hash.to_h.values.map(&:to_s).map(&:size).max
    hash.map do |path, uniq_ips|
      "| %#{key_max_size}s | %#{value_max_size}s %s |" %
        [path, uniq_ips, value_label]
    end.join("\n")
  end

  def pair_arr_sort 
    lambda {|(k, v)| v }
  end
end

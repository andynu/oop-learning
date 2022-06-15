#!/usr/bin/env ruby
require 'minitest/autorun'

require_relative './parser'

class TestParser < Minitest::Test
  def test_parser_result
    expected = <<~STR.strip
      WEBPAGES WITH MOST PAGE VIEWS:
      /help_page/1 - 4 visits
      /index - 1 visits
      /home/2 - 1 visits
      /home - 1 visits
      /contact - 1 visits
      WEBPAGES WITH MOST UNIQUE PAGE VIEWS:
      /help_page/1 - 3 unique views
      /index - 1 unique views
      /home/2 - 1 unique views
      /home - 1 unique views
      /contact - 1 unique views
    STR
    actual = Parser.new('links.log').run

    assert_equal expected, actual
  end
end

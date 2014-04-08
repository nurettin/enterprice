require 'candle_stream'
require 'multi_candle_stream'
require 'test/unit'
require 'set'

class TestIO< Test::Unit::TestCase

  def test_candle_stream
    r= []
    s= Enterprice::IO::CandleStream.start(20) do |c|
      r<< c
    end
    s<< [1, 1000, 10]
    s<< [5, 900, 10]
    s<< [15, 1100, 10]
    s<< [20, 990, 10]
    s<< [31, 992, 10]
    s<< [41, 995, 10]

    assert_equal r, [
      [1, 1000, 1100, 900, 990, 40], 
      [21, 990, 992, 992, 992, 10]]
    # force a block call with latest state
    s.call
    assert_equal r, [
      [1, 1000, 1100, 900, 990, 40], 
      [21, 990, 992, 992, 992, 10], 
      [41, 992, 995, 995, 995, 10]]
  end

  def test_multi_candle_stream
    r= []
    s= Enterprice::IO::MultiCandleStream.start(10) do |c|
      r<< c
    end

    s<< ["A", 1, 1000, 10]
    s<< ["B", 1, 500, 10]
    s<< ["A", 2, 1010, 10]
    s<< ["B", 5, 565, 10]
    s<< ["B", 7, 440, 10]
    s<< ["A", 7, 990, 10]
    s<< ["A", 9, 995, 10]
    s<< ["B", 10, 996, 10]
    s<< ["A", 11, 555, 10]
    s<< ["A", 12, 345, 10]
    s<< ["B", 21, 1011, 10]
    s<< ["B", 23, 998, 10]
    s<< ["A", 24, 600, 10]

    # actually they come out in the order they were first placed in the stream. This is just a demo.
    assert_equal Set.new(r), Set.new([
      ["A", 1, 1000, 1010, 990, 995, 40], 
      ["A", 11, 995, 555, 345, 345, 20],
      ["B", 1, 500, 996, 440, 996, 40], 
      ["B", 11, 996, 996, 996, 996, 0]])
  end

end


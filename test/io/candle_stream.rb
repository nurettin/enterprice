require 'candle_stream'
require 'test/unit'

class TestIO< Test::Unit::TestCase

  def test_candlestream
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

    assert_equal r, [[1, 1000, 1100, 900, 990, 40], [21, 990, 992, 992, 992, 10]]
    # force a block call with latest state
    s.call
    assert_equal r, [[1, 1000, 1100, 900, 990, 40], [21, 990, 992, 992, 992, 10], [41, 992, 995, 995, 995, 10]]

  end

end


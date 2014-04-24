require 'enterprice'
require 'minitest/autorun'

class TestIO< MiniTest::Test

  def test_moving_average_stream_sma
    r= []
    mas= Enterprice::IO::MovingAverageStream.start(:sma, 5) do |avg|
      r<< avg
    end

    data= [1, 2, 3, 4, 3, 4, 3, 2, 1].map(&:to_f)
    data.each do |d|
      mas<< d
    end

    c= []
    data.each_cons(5) do |a|
      c<< a.reduce(:+)/ a.length
    end

    assert_equal r, c
  end

  def test_signal_stream
    r= []
    ss= Enterprice::IO::SignalStream.start(:sma, 2, 5, 0) do |signal, value, eff, avg1, avg2|
      r<< [signal, value, eff, avg1, avg2]
    end
    
    data= [1, 2, 3, 4, 3, 4, 3, 2, 1, 2, 3].map(&:to_f)
    data.each do |d|
      ss<< d
    end

    assert_equal r, [
      [:hold, 3.0, 0, 3.5, 2.6], 
      [:hold, 4.0, 0, 3.5, 3.2], 
      [:hold, 3.0, 0, 3.5, 3.4], 
      [:buy, 2.0, 0, 2.5, 3.2], 
      [:hold, 1.0, 0, 1.5, 2.6], 
      [:hold, 2.0, 0, 1.5, 2.4], 
      [:sell, 3.0, 0.5, 2.5, 2.2]]

    buy= r.find{ |s| s[0]== :buy }
    assert buy[3]< buy[4]
    sell= r.find{ |s| s[0]== :sell }
    assert sell[3]> sell[4]
  end

end


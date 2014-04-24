require_relative './moving_average_stream'

module Enterprice; module IO

class SignalStream
  attr_reader :ma_type
  attr_reader :window1
  attr_reader :window2

  def initialize(ma_type, window1, window2, stop_loss, block)
    @avg1= nil
    @avg2= nil
    @sma1= MovingAverageStream.new(ma_type, window1, proc { |avg| @avg1= avg })
    @sma2= MovingAverageStream.new(ma_type, window2, proc { |avg| @avg2= avg })
    @stop_loss= stop_loss
    @block= block
    reset
  end

  def <<(value)
    @sma1<< value
    @sma2<< value
    @last_value= value
    if !@avg1.nil? && !@avg2.nil?
      @temp_state= :hold
      if @state== :buy && value< @last_price* @stop_loss
        @state= :stop_loss
        @efficiency+= 1.0* (value- @last_price)/ @last_price
        @last_price= value
        @temp_state= @state
      elsif @avg1< @avg2 && !(@state== :buy || @state== :stop_loss)
        @state= :buy
        @last_price= value
        @temp_state= @state
      elsif @avg1> @avg2 && @state== :buy
        @state= :sell
        @temp_state= @state
        @efficiency+= 1.0* (value- @last_price)/ @last_price
      end
      call
    end
  end

  def call
    @block.call @temp_state, @last_value, @efficiency, @avg1, @avg2
  end

  def reset
    @state= :hold
    @temp_state= :hold
    @last_value= nil
    @last_price= nil
    @efficiency= 0
  end

  def self.start(ma_type, window1, window2, stop_loss, &block)
    SignalStream.new(ma_type, window1, window2, stop_loss, block)
  end
end

end; end # Enterprice.IO


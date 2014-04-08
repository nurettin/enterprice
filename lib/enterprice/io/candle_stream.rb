module Enterprice; module IO

class CandleStream
  attr_accessor :period

  def self.start(period, &block)
    CandleStream.new(period, block)
  end

  def initialize(period, block)
    @pivot= nil
    @open= nil
    @period= period
    @prev_close= 0.0
    @block= block
    reset_state
  end

  def << (row)
    ts, price, amount= row
    @pivot||= ts
    @open||= price

    if ts> @pivot+ @period- 1
      call
      @prev_close= @close
      reset_state
      @pivot+= @period
    end
    
    while ts> @pivot+ @period- 1
      call_blank
      @pivot+= @period
    end
    
    if ts< @pivot+ @period
      @open= @prev_close if @prev_close!= 0.0
      @high= price if price> @high
      @low= price if price< @low
      @close= price
      @volume+= amount
    end
  end

  def call
    @block.call [@pivot, @open, @high, @low, @close, @volume]
  end

private
  def call_blank
    @block.call [@pivot, @prev_close, @prev_close, @prev_close, @prev_close, 0]
  end

  def reset_state
    @high= -Float::INFINITY
    @low= Float::INFINITY
    @close= -Float::INFINITY
    @volume= 0
  end
end # Enterprise::CandleStream

end # IO
end # Enterprise


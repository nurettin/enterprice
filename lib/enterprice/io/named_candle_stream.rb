require_relative './candle_stream'

module Enterprice; module IO

class NamedCandleStream< Enterprice::IO::CandleStream
  attr_accessor :name

  def initialize(period, name, block)
    @name= name
    super(period, block)
  end

  def call
    @block.call [@name, @pivot, @open, @high, @low, @close, @volume]
  end

  def call_blank
    @block.call [@name, @pivot, @prev_close, @prev_close, @prev_close, @prev_close, 0]
  end
end

end; end

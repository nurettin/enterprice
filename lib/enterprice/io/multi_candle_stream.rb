require_relative './named_candle_stream'

module Enterprice; module IO

class MultiCandleStream
  def initialize(period, block)
    @streams= {}
    @period= period
    @block= block
  end

  def << (row)
    if @streams[row[0]].nil?
      @streams[row[0]]= NamedCandleStream.new(@period, row[0], @block)
    end
    @streams[row[0]]<< row[1..-1]
  end

  def self.start(period, &block)
    MultiCandleStream.new(period, block) 
  end
end

end; end

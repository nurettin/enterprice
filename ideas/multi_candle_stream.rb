require_relative "../lib/enterprice/io/candle_stream"

class NamedCandleStream< Enterprice::IO::CandleStream
  attr_accessor :name

  def initialize(period, name, block)
    @name= name
    super(period, block)
  end

  def call
    @block.call [@name, @pivot, @open, @high, @low, @close, @volume]
  end

  def call_empty
    @block.call [@name, @pivot, @prev_close, @prev_close, @prev_close, @prev_close, 0]
  end
end

class MultiCandleStream
  attr_accessor :streams
  attr_accessor :period
  attr_accessor :block

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

mcs= MultiCandleStream.start(10) do |r|
  p r
end

mcs<< ["wtf", 1, 1001, 10]
mcs<< ["omg", 5, 1000, 10]
mcs<< ["wtf", 10, 1004, 10]
mcs<< ["omg", 15, 995, 10]
mcs<< ["wtf", 20, 1002, 10]
mcs<< ["omg", 20, 1004, 10]

require 'indicator/mixin'

module Enterprice; module IO

class MovingAverageStream
  attr_reader :window
  attr_reader :type

  def initialize(type, window, block)
    supported= %i(sma wma ema dema tema kama)
    if !supported.include?(type)
      raise "Error: unsupported smoothing method: #{type}, supported methods are: #{supported}"
    end
    @type= type
    @window= window
    @length= case type
      when :kama then window+ 1
      when :dema then window* 2
      when :tema then window* 3
      else window
      end
    @block= block
    @data= []
  end

  def <<(value)
    @data<< value
    return if @data.length< @length
    @data.shift if @data.length> @length
    call
  end

  def call
    @block.call @data.indicator(@type, @window)[0]
  end

  def self.start(type, window, &block)
    MovingAverageStream.new(type, window, block)
  end
end

end; end # Enterprice.IO


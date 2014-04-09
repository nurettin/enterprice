require "enterprice"

mcs= Enterprice::IO::MultiCandleStream.start(10) do |r|
  p r
end



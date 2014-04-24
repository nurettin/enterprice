[![Gem Version](https://badge.fury.io/rb/enterprice.svg)](http://badge.fury.io/rb/enterprice)

## Tests
  
  run `rake test`

## Utilities

### IO

* Candle Streaming

    This utility calls a provided block of code for each bar as data is pushed in and aggregated.

* Multi Candle Streaming
  
    Same as candle streaming, but for multiple stock options. Calls provided block with the name of the option.

* Moving Average Streaming
  
    This utility calls a provided block of code whenever a moving average window is calculated.

* Signal Streaming
  
    Whenever two internal Moving Average Streams cross, signals a buy or sell. Otherwise signals hold or stop-loss.

## FAQ
  
* It should be "enterprise".

  That name is taken on rubyforge, so I jest.

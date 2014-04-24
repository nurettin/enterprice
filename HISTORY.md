### 0.2.4

* Added dependency on ta-indicator which depends on ta-lib.

<pre>
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar zxf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure LDFLAGS="-lm"
make
sudo make install
sudo cp /usr/local/lib/libta_* /usr/lib
</pre>

* Added moving average stream for sma, wma, ema, dema, tema, kama methods of curve smoothing.
* Added signal stream for two moving averages. There is also a stop-loss signal which stops all trading.
* Switched to MiniTest because it comes with ruby.

### 0.1.4

* Fix path so you can do `require "enterprice"` instead of having to do `require "enterprice/io/blah"`

### 0.1.3

* Switch to semantic versioning.
* Fix horrible bug caused by change of paths.

### 0.0.2

* Added multi candle streaming utility for managing multiple options at once.
* Added tests for multi candle streaming.

### 0.0.1-1 Unreleased

* Added candle stream test.

### 0.0.1

* Initialized repo, added candle streaming utility.


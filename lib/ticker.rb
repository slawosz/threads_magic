class Ticker

  def initialize(interval)

    @interval  = interval
    @callbacks = []
  end

  def on_tick(&block)
    @callbacks << block
  end

  def start
    @running = true
    @ticker_thread = Thread.new do
      while @running
        sleep @interval
        @callbacks.first.call
      end
    end
  end

  def stop
    @running = false
  end
end

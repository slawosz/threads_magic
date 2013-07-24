class Ticker

  def initialize(interval)

    @interval  = interval
    @callbacks = []
  end

  def on_tick(&block)
    @callbacks << block
  end

  def start
    @ticker_thread = Thread.new do
      sleep @interval
      @callbacks.first.call
    end
    @ticker_thread.join
  end
end

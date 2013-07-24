class Ticker

  def initialize(interval)
    @interval  = interval
    @callbacks = []
    @mutex     = Mutex.new
  end

  def on_tick(&block)
    @callbacks << block
  end

  def start
    @running = true
    @ticker_thread = Thread.new do
      while @running
        sleep @interval
        @callbacks.each do |callback|
          @mutex.synchronize { callback.call if @running }
        end
      end
    end
  end

  def stop
    @running = false
  end
end

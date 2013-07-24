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
        @mutex.synchronize do
          if @running
            @callbacks.map do |callback|
              Thread.new { callback.call }
            end#.map(&:join) # when on, on tick need to finish (and provide to problems). The reason is that including thread is waiting for these threads to finish execute
          end
        end
      end
    end
  end

  def stop
    @running = false
  end
end

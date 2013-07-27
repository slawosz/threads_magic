require 'thread'

class BlockingQueue

  def initialize
    @q      = Array.new
    @mutex  = Mutex.new
    @signal = ConditionVariable.new
  end

  def push(elem)
    print '.'
    @mutex.synchronize do
      @q.push(elem)
      @signal.broadcast
    end
  end

  def pop
    @mutex.synchronize do
      elem = @q.pop

      # find example that proves that if is wrong
      while !elem
        @signal.wait(@mutex)
        elem = @q.pop
      end
      elem
    end
  end

  def length
    @q.length
  end
end

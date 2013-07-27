require_relative '../../lib/blocking_queue'

q = BlockingQueue.new

# is threadsafe (run on rbx/jruby)

1000.times do
  Thread.new do
    # this will make thread scheduler switch thread more often
    sleep 0.01
    q.push 'foo'
  end
end

puts "After 1000 threads, BlockingQueue lenght is #{q.length}, and should be 1000"

a = Array.new

# is not threadsafe (run on rbx/jruby)
1000.times do
  Thread.new do
    # this will make thread scheduler switch thread more often, so we see bigger difference
    sleep 0.01
    a.push 'foo'
  end
end

puts "After 1000 threads, array lenght is #{a.length}, and should be 1000"

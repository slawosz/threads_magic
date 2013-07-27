require_relative '../../lib/blocking_queue'

q = BlockingQueue.new
1000.times do
  q.push 'foo'
end

# is threadsafe
500.times do
  Thread.new do
    # this will make thread scheduler switch thread more often
    sleep 0.01
    q.pop
  end
end

puts "After 500 threads, BlockingQueue lenght is #{q.length}, and should be 500"

# is not threadsafe
a = Array.new
1000.times do
  a.push 'foo'
end

500.times do
  Thread.new do
    # this will make thread scheduler switch thread more often, so we see bigger difference
    sleep 0.01
    a.pop
  end
end

puts "After 500 threads, array lenght is #{a.length}, but should be 500"

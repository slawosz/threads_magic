require_relative '../../lib/blocking_queue'

q = BlockingQueue.new

Thread.new do
  sleep 2
  q.push 'foo'
end

puts "Queue retuns '#{q.pop}', and should return 'foo'"

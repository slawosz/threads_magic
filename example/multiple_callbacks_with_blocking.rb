require_relative '../lib/ticker'

ticker = Ticker.new(1.5)

ticker.on_tick do
  puts Time.now.strftime("tick1: %T.%L")
  sleep 0.1
end

ticker.on_tick do
  puts Time.now.strftime("tick2: %T.%L")
end

puts Time.now.strftime("%T.%L")
ticker.start
sleep 6.1
puts Time.now.strftime("end: %T.%L")
ticker.stop
puts 'No more ticking'
sleep 5

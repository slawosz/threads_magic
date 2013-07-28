require_relative '../../lib/ticker'

ticker = Ticker.new(1.5)

ticker.on_tick do
  puts Time.now.strftime("tick1: %T.%L")
  sleep 2.1 # this join
  #puts Time.now.strftime("tick1 end: %T.%L")
end

100.times do
  ticker.on_tick do
    puts Time.now.strftime("tick2: %T.%L")
  end
end

puts Time.now.strftime("start: %T.%L\n")
ticker.start
p 'ticker started;'
sleep 6.1
puts Time.now.strftime("end:   %T.%L")
ticker.stop
puts 'No more ticking'
sleep 5

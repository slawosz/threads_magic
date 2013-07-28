require_relative '../../lib/runner'

def print_time
  puts Time.now.strftime("%T.%L")
end

i = 0
j = 0
Runner.loop runs: 2 do
  i += 1

  run do
    puts Time.now.strftime("no delay 1x#{i}: %T.%L")
    sleep 0.1
  end

  loop runs: 2 do
    j += 1
    run do
      p '---'
      puts Time.now.strftime("no delay 2x#{j}: %T.%L")
      sleep 0.1
      puts Time.now.strftime("delay by 0.1: %T.%L")
    end

    run do
      puts Time.now.strftime("no delay 3x#{j}: %T.%L")
      sleep 0.1
    end
  end
end

p 'done'
gets

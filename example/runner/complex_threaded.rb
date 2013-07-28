require_relative '../../lib/runner'

def print_time
  puts Time.now.strftime("%T.%L")
end

Runner.loop runs: 1 do
  run do
    puts Time.now.strftime("this runs normally: %T.%L")
    sleep 0.1
  end
  loop runs: 2 do |r|
    before do
      puts Time.now.strftime("before section (%T.%L)")
      sleep 0.5
    end
    run do
      puts Time.now.strftime("delay by 0.5: %T.%L")
    end
    run do
      puts Time.now.strftime("delay by 0.5: %T.%L")
    end
  end
  run do
    puts Time.now.strftime("this runs normally: %T.%L")
    sleep 0.1
  end
end

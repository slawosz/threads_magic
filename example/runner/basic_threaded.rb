require_relative '../../lib/runner'

Runner.loop runs: 2 do |r|
  r.run { print_time }
  r.loop runs: 3 do
    r.run { print_time }
    r.run { print_time }
  end
end


def print_time
  puts Time.now.strftime("tick1: %T.%L")
end

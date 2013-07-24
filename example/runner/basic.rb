require_relative '../../lib/runner'

Runner.loop runs: 2 do |r|
  puts :foo
  r.loop runs: 3 do
    puts "  bar"
    puts "  baz"
  end
end

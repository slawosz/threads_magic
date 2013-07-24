require_relative '../../lib/runner'

Runner.loop runs: 2 do |r|
  r.run { puts :foo }
  r.loop runs: 3 do
    r.run { puts "  bar" }
    r.run { puts "  baz" }
  end
end

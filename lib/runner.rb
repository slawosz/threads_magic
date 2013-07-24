class Runner

  def self.loop(opts = { runs: 1 }, &block)
    new.loop(opts, &block)
  end

  def loop(opts = { runs: 1 }, &block)
    opts[:runs].times do
      block.call(self)
    end
  end
end

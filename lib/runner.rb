class Runner

  def self.loop(opts = { runs: 1 }, &block)
    runner = new
    runner.loop(opts, &block)
    runner.run_all
  end

  def initialize
    @collected_runs = []
  end

  def loop(opts = { runs: 1 }, &block)
    opts[:runs].times do
      block.call(self)
    end
  end

  def run(&block)
    @collected_runs << block
  end

  def run_all
    @collected_runs.each &:call
  end
end

require 'thread'

$ids = []
class Runner
  attr_reader :collected_runs

  def self.loop(opts = { runs: 1 }, &block)
    runner = new
    runner.loop(opts, &block)
    runner.run_all
  end

  def initialize
    @collected_runs = []
    @current_runs   = []
    @before_runs    = []
  end

  def loop(opts = { runs: 1 }, &block)
    # get_all_runs from here
    opts[:runs].times do
      self.instance_exec &block
    end

    collect_runs
  end

  def run(&block)
    @collected_runs << block
  end

  def before(&block)
    @mutex     = Mutex.new
    @broadcast = ConditionVariable.new
    @before_runs << block
  end

  def run_all
    if @mutex
      p mutex
      @mutex.synchronize do
        @before_runs.map do |collected_run|
          Thread.new(&before_runs)
        end.map(&:join)
        @broadcast.broadcast
      end

      @mutex.synchronize do
        @broadcast.wait(@mutex)

        @collected_runs.map do |collected_run|
          Thread.new(&collected_run)
        end.map(&:join)
      end
    else
      # require 'pry'
      # binding.pry
      p @collected_runs.count
      p Time.now.strftime("run all: %T.%L")
      # TODO: make propagation to childs
      @collected_runs.map do |collected_run|
        Thread.new(&collected_run)
      end#.map(&:join)
    end
  end

  def collect_runs
    @collected_runs += @current_runs

    @current_runs    = []
  end
end



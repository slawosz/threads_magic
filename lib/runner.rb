require 'thread'

$ids = []
class Runner

  def self.loop(opts = { runs: 1 }, &block)
    runner = new
    runner.loop(opts, &block)
  end

  def initialize
    @collected_runs = []
    @before_runs    = []
  end

  def loop(opts = { runs: 1 }, &block)
    opts[:runs].times do
      block.call(child_runner)
    end
    run_all
  end

  def run(&block)
    $ids << self.object_id
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
      p Time.now.strftime("run all: %T.%L")
      # TODO: make propagation to childs
      @collected_runs.map do |collected_run|
        Thread.new(&collected_run)
      end#.map(&:join)
    end
  end

  def child_runner
    @child_runner ||= Runner.new
  end
end



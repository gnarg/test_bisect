# encoding: utf-8
require 'rake/tasklib'

module TestBisect
  class BisectTask < Rake::TaskLib
    attr_accessor :name

    # We assume the task used to run the tests is "test" but if not,
    # specify here
    attr_accessor :test_task_name

    # We try to get the list of suspects from the test task, but they
    # can be manually specified here
    attr_accessor :suspects

    # Create a test bisect task
    # if the test task which runs the tests is not "test" then specify
    # is as the second arg.
    def initialize(name=:bisect)
      @name = name
      @test_task_name = :test
      # might as well take the last one
      ObjectSpace.each_object(Rake::TestTask) do |obj|
        @test_task = obj if obj != self
      end
      @suspects = @test_task.instance_variable_get(:@test_files) || []
      @suspects += FileList[@test_task.pattern]
      yield self if block_given?
      define
    end

    def define
      desc "Bisect test suite files to find file which makes victim fail"
      task @name, [:victim] do |task, args|
        @test_task.pattern = nil
        criminal = bisect(@suspects, args.victim)
        puts "FOUND: #{criminal}"
      end
      self
    end

    def bisect(suspects, victim)
      return suspects[0] if suspects.size == 1

      pivot = suspects.size / 2
      suspects.partition {|file| suspects.index(file) < pivot }.each do |part|
        begin
          @test_task.test_files = part
          Rake::Task[@test_task_name].reenable
          Rake::Task[@test_task_name].invoke
          puts "------ PASSED -------"
          next
        rescue RuntimeError => e
          if e.message =~ /Command failed with status/
            puts "------ FAILED -------"
            return bisect(part, victim)
          else
            raise
          end
        end
      end
    end
  end
end

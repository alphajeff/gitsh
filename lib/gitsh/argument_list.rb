module Gitsh
  class ArgumentList
    def initialize(args)
      @args = args
    end

    def length
      args.length
    end

    def values(env)
      @args.map { |arg| arg.value(env) }.flatten
    end

    private

    attr_reader :args
  end
end

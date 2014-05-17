module Middleman
  module BitBalloon
    class Options < Struct.new(:token, :site, :build_before); end

    class << self

      def options
        @@options
      end

      def registered(app, options_hash={}, &block)
        options = Options.new(options_hash)

        yield options if block_given?

        @@options = options

        app.send :include, Helpers
      end

      alias :included :registered
    end

    module Helpers
      def options
        ::Middleman::BitBalloon.options
      end
    end
  end
end

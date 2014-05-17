require "bitballoon"
require "middleman-core/cli"
require "middleman-bitballoon/extension"

module Middleman
  module Cli

    # This class provides a "deploy" command for the middleman CLI.
    class Deploy < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :deploy

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "deploy [options]", "Deploy a middleman built site with BitBalloon"
      method_option "build_before",
        :type     => :boolean,
        :aliases  => "-b",
        :desc     => "Run `middleman build` before the deploy step"
      def deploy
        build_before(options)
        process
      end

      protected

      def build_before(options={})
        build_enabled = options.fetch('build_before', self.deploy_options.build_before)

        if build_enabled
          # http://forum.middlemanapp.com/t/problem-with-the-build-task-in-an-extension
          run('middleman build') || exit(1)
        end
      end

      def print_usage_and_die(message)
        raise Error, <<-MSG
ERROR: #{message}

Configure the bitballoon extension in config.rb:

activate :bitballoon do |bitballoon|
  bitballoon.token = ENV['BB_TOKEN']
  bitballoon.site  = "mysite.bitballoon.com"
end
MSG
      end

      def process
        puts "Deploying to BitBalloon site #{deploy_options.site}"
        server_instance   = ::Middleman::Application.server.inst

        client = ::BitBalloon::Client.new(:access_token => deploy_options.token)
        client.sites.get(deploy_options.site).tap do |site|
          site.update(:dir => server_instance.build_dir)
          puts "Waiting for BitBalloon to Process the deploy"
          site.wait_for_ready
          puts "Deploy ready at #{site.url}"
        end
      end

      def deploy_options
        options = nil

        begin
          options = ::Middleman::Application.server.inst.options
        rescue NoMethodError
          print_usage_and_die "You need to activate the bitballoon extension in config.rb."
        end

        unless options.token
          print_usage_and_die "The bitballoon extension requires you to set a token."
        end

        unless options.site
          print_usage_and_die "The bitballoon extension requires you to set a site."
        end

        options
      end
    end

    # Alias "d" to "deploy"
    Base.map({ "d" => "deploy" })
  end
end

# Middleman::Bitballoon

Deploys a [Middleman](http://middlemanapp.com/) built site to BitBalloon

## Installation

Add this to the Gemfile of the repository of your middleman site:

    gem 'middleman-bitballoon'

And then execute:

    $ bundle install

## Usage

    $ middleman deploy [--build-before]

## Configuration

Activate and configure middleman-bitballoon in your config.rb:

```ruby
activate :bitballoon do |bitballoon|
  bitballoon.token = ENV["BB_TOKEN"]
  bitballoon.site  = "my-bitballoon-site.bitballoon.com"

  # Optional: always run a build before deploying
  bitballoon.build_before = true
end
```

## Contributing

1. Fork it ( http://github.com/bitballoon/middleman-bitballoon/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

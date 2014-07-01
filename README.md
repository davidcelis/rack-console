# Rack::Console

Find yourself missing a `rails console` analogue in your other Ruby web applications? This lightweight gem provides a Rack::Console that will load your Rack application's code and environment into an IRB or Pry session. Either use `Rack::Console.start` directly, or run the provided `rack-console` executable.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-console'
```

And then execute:

```bash
$ bundle install
```

Or install it system-wide:

```bash
$ gem install rack-console
```

## Usage

rack-console ships with a `rack-console` executable that will load your application in an IRB shell (or
[Pry](http://pryrepl.org) if that's included in your Gemfile). Assuming you have a `config.ru` file in the current directory, simply run:

```bash
$ bundle exec rack-console
pry(main)>
```

Additionaly, like `rails console`, you can provide your environment as an argument:

```ruby
$ bundle exec rack-console production
pry(main)> ENV['RACK_ENV']
=> "production"
```

## Framework CLI Example

Because rack-console is wrapped in a class, it's easy to provide a `console` subcommand to a CLI for your own Rack framework. For example, here's how you could hypothetically implement a `console` subcommand for a generic Rack CLI using [Thor](https://github.com/erikhuda/thor):

```ruby
require 'rack/console'
require 'thor'

module Rack
  class CLI < Thor
    desc 'console [ENVIRONMENT]', 'Start a Rack console'
    def console(environment = 'development')
      ENV['RACK_ENV'] = environment

      Rack::Console.start
    end
  end
end

Rack::CLI.start(ARGV)
```

## Contributing

1. [Fork it](https://github.com/davidcelis/rack-console/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. [Create a new Pull Request](https://github.com/davidcelis/rack-console/compare)

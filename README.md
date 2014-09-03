# Rack::Console [![Build Status](https://travis-ci.org/davidcelis/rack-console.svg?branch=master)](https://travis-ci.org/davidcelis/rack-console)

Find yourself missing a `rails console` analogue in your other Ruby web applications? This lightweight gem provides a Rack::Console class that will load your Rack application's code and environment into an IRB or Pry session. Either use `Rack::Console.new.start` directly, or run the provided `rack-console` executable.

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

Rack::Console ships with a `rack-console` executable that will load your application in an IRB shell (or
[Pry](http://pryrepl.org) if that's included in your Gemfile). Assuming you have a `config.ru` file in the current directory, simply run:

```ruby
$ bundle exec rack-console
pry(main)>
```

Rack::Console supports some of the same things that `rails console` provides, as well as arguments used in `rackup`:

 * An `app` method that will return your underlying Rack application with [rack-test](https://github.com/brynary/rack-test) methods mixed in. You can perform fake requests to your app (e.g. `response = app.get('/')`)
 * Supply the RACK_ENV as an argument (`bundle exec rack-console production`)
 * A `reload!` method to discard new code or defined variables/constants
 * The `-c` option (or `--config`) to specify a non-standard `config.ru` file
 * The `-r` option (or `--require`) to require a file/library before Rack::Console loads
 * The `-I` option (or `--include`) to specify paths (colon-separated) to add to `$LOAD_PATH` before Rack::Console loads

## Framework CLI Example

Because Rack::Console is just a class, it's easy to provide a `console` subcommand to a CLI for your own Rack framework. For example, here's how you could hypothetically implement a `console` subcommand for a generic Rack CLI using [Thor](https://github.com/erikhuda/thor):

```ruby
require 'rack/console'
require 'thor'

module Rack
  class CLI < Thor
    desc 'console [ENVIRONMENT]', 'Start a Rack console'

    method_option :config,  aliases: '-c', type: 'string',
                            desc: 'Specify a Rackup file (default: config.ru)'
    method_option :require, aliases: '-r', type: 'string',
                            desc: 'Require a file/library before console boots'
    method_option :include, aliases: '-I', type: 'string',
                            desc: 'Add colon-separated paths to $LOAD_PATH'

    def console
      # Set a custom intro message:
      #   ENV['RACK_CONSOLE_INTRO'] = 'Loading Rack::Console...'
      #
      # Or, to prevent an intro message from being printed at all:
      #   ENV['IGNORE_RACK_CONSOLE_INTRO'] = false
      Rack::Console.new(options).start
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

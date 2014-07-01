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

rack-console ships with a `rack-console` executable:

```bash
$ bundle exec rack-console
2.1.2p95>
```

If `pry` is also included in your Gemfile, rack-console will load that instead:

```bash
$ bundle exec rack-console
pry(main)>
```

rack-console also provides itself as a class if you want to create a simple console for your own Rack framework:

```ruby
require 'rack/console'

Rack::Console.start
```

## Contributing

1. [Fork it](https://github.com/davidcelis/rack-console/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. [Create a new Pull Request](https://github.com/davidcelis/rack-console/compare)

# Supersimplehttp

Supper Simple HTTP is a simple HTTP server created in ruby. At it's current stage it has no real world use there are way better frameworks. I simple made this project to learn Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'supersimplehttp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install supersimplehttp

## Usage

Create a new ruby file

```rb
require 'supersimplehttp'

Supersimplehttp::Server.new('localhost', 5000)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/supersimplehttp.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

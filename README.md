# I18n::Callbacks

Wrap your `I18n.t` calls in `before` and/or `after` hooks.

This gem provides the `I18n::Backend::Callbacks` backend.

You pass it an I18n backend to call plus before/after callbacks to pre-/post-
process the calls.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n-callbacks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-callbacks

## Usage

Supply either a `:before` or `:after` proc to the constructor, process I18n.t
calls.

* `:before` - takes 3 parameters: locale, key and options,
* `:after` - takes 4 parameters: locale, key and options, and the result of
  the call to the backend that you are wrapping.

Suppose you want all translated strings to be prefixed by the key used to
access them:

```ruby
require "i18n"
require "i18n/callbacks"

wrapped = I18n::Backend::Simple.new

# ...load your translations (normally from YAML files)
wrapped.store_translations(:en, {foo: "bar"})

I18n.backend = I18n::Backend::Callbacks.new(
  wrapped,
  after: ->(locale, key, options={}, result) { "#{key}: #{result}" }
)

I18n.t(:foo) # => "foo: bar"
```

See also the `examples` directory.

## Development

Run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/cantierecreativo/i18n-callbacks. This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

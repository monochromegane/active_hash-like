# ActiveHash::Like [![Build Status](https://travis-ci.org/monochromegane/active_hash-like.svg?branch=master)](https://travis-ci.org/monochromegane/active_hash-like)

Custom matcher for ActiveHash. It provides `like` operator.

## Usage

After install ActiveHash::Like, you can use `like` method.

```rb
class Country < ActiveHash::Base; end

Country.like(name: 'Cana%')
```

If you want to use `like` in the where method parameter, you can use `ActiveHash::Match::Like` matcher.

```rb
# Specify match type.
Country.where(name: ActiveHash::Match::Like.new('Cana%'))

# Or use forward, backward, partial method.
Country.where(name: ActiveHash::Match::Like.forward('Cana'))
```

## Custom matcher

`ActiveHash::Match::Like` is one of custom matcher. You can create your custom matcher.
It should have `call` method like the following:

```rb
class MyCustomMatcher
  attr_accessor :pattern

  def initialize(pattern)
    self.pattern = pattern
  end

  def call(value)
    # Case ignore matcher
    value.upcase == pattern.upcase
  end
end

Country.where(name: MyCustomMatcher.new('pattern'))
```

So, you can use `Proc` object as simple custom matcher.

```rb
Country.where(name: ->(value){ value == 'some value'})
```

## OR condition

you can use key: `or` like the following:

```rb
Country.where(name: 'Canada', or: {field1: 'foo', field2: 'bar'})
#=> name = 'Canada' and (field1 = 'foo' or field2 = 'bar')
```

If you want to use `or` to one column, you must use custom matcher.

```rb
Country.where(name: ->(val){val == 'Canada' || val == 'US'})
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_hash-like'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_hash-like

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_hash-like.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


[![Gem Version](https://badge.fury.io/rb/time_extended.svg)](http://badge.fury.io/rb/time_extended)

# TimeExtended Gem

A simple gem for extension the Ruby class `DateTime`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'time_extended'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_extended

## Usage

* DateTime.now.ymd => strftime("%y %m %d")
* DateTime.now.Bd => strftime("%B %d")
* DateTime.now.M3N => strftime("%M %3N")

## Contributing

1. Fork it ( https://github.com/randsina/bsuir-courses-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

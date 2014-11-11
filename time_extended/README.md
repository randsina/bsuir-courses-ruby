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

```ruby
require 'date'
require 'time_extended'


DateTime.now.ymd # => strftime("%y %m %d")  => "14 11 06"
DateTime.now.Bd  # => strftime("%B %d")     => "November 06"
DateTime.now.M3N # => strftime("%M %3N")    => "51 963"
```

## Contributing

1. Fork it ( https://github.com/randsina/bsuir-courses-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

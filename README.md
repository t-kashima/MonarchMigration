# MonarchMigration

Generate migration file for Monarch

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monarch_migration'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monarch_migration

## Usage

### Add column in the table

ex. add age and device column in User table.

```
bundle exec monarch_migration generate addColumnUser age:int device:int
```

### Remove column in the table

ex. remove age and device column in User table.

```
bundle exec monarch_migration generate removeColumnUser age device
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec monarch_migration` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/t-kashima/monarch_migration. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


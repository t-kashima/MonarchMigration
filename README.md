# MonarchMigration

This gem is generate a migration file for Monarch.

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

When you want to add age and device columns to User table.

```
bundle exec monarch_migration generate addColumnUser age:int device:int
```

When you want to remove age column to User table.

```
bundle exec monarch_migration generate removeColumnUser age
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/t-kashima/MonarchMigration. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


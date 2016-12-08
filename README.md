# MonthConstrain

month_constrain is for managing columns of Date type as month information in ActiveRecord

Converts date information such as `Date.new(2016, 12, 12)` and `"2016-01"` to Date Class.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'month_constrain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install month_constrain

## Usage

**In your model**

```rb
class Book < ApplicationRecord
  acts_as_month_constrain :published_on

  # ...
end
```

Create Record

e.g.

```rb
>> Client.create(published_on: '2016-01')
# => #<Client id: 1, published_on: "2016-01-01">

>> Client.create(published_on: Date.new(2016, 1, 16))
# => #<Client id: 1, published_on: "2016-01-01">

```

Find Record

e.g.

```rb
>> Client.published_on('2016-01')
# => #<ActiveRecord::Relation [#<Client id: 1, published_on: "2016-01-01">]>

>> Client.published_on(Date.new(2016, 1, 16))
# => #<ActiveRecord::Relation [#<Client id: 1, published_on: "2016-01-01">]>

>> Client.published_on_in(Date.new(2016, 1, 16), nil)
# => #<ActiveRecord::Relation [#<Client id: 5, published_on: "2016-01-01">, #<Client id: 6, published_on: "2016-02-01">, #<Client id: 7, published_on: "2016-03-01">]>

>> Client.published_on_in('2016-01', '2016-02')
# => #<ActiveRecord::Relation [#<Client id: 5, published_on: "2016-01-01">, #<Client id: 6, published_on: "2016-02-01">]>

```


## Contributing

1. Fork it ( https://github.com/speee/month_constrain/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

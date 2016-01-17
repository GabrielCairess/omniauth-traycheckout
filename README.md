# OmniAuth TrayCheckout

This is the official OmniAuth strategy for authenticating to TrayCheckout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-traycheckout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-traycheckout

## Usage

#### Production

```ruby
use OmniAuth::Builder do
  provider :traycheckout, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end
```

#### Sandbox

```ruby
provider :traycheckout, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'],
    {
      :client_options => {
        :site => 'https://checkout.sandbox.tray.com.br',
        :authorize_url => '/authentication',
        :token_url => 'https://api.sandbox.traycheckout.com.br/api/authorizations/access_token',
      }
    }
```

## Example

[Source Code](https://github.com/gabrielpedepera/omniauth-test-traycheckout)
[Application Heroku](http://omniauth-test-traycheckout.herokuapp.com/)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabrielpedepera/omniauth-traycheckout.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

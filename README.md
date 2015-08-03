# PicturepathAUI

[![Build Status](https://travis-ci.org/antillas21/picturepath_aui.svg?branch=master)](https://travis-ci.org/antillas21/picturepath_aui)
[![Code Climate](https://codeclimate.com/github/antillas21/picturepath_aui/badges/gpa.svg)](https://codeclimate.com/github/antillas21/picturepath_aui)

A ruby wrapper around the PicturePath AUI API. PicturePath provides an API to post virtual tours to Realtor.com and other real estate websites.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'picturepath_aui'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install picturepath_aui

## Usage

We want to keep a simple API to make requests to the PicturePath AUI API.

Here's an example on how to do the most basic operation.

```ruby
# First, configure your client connection
client = PicturepathAUI::Client.new(username: "username", password: "password")

# Next, build your request payload
payload = PicturepathAUI::Request.new({
  site: 2845, order_number: 1234, product_line: "LINK",
  street1: "742 Evergreen Terrace", street2: nil, city: "Springfield",
  state: "IL", zip_code: 62701, mls_id: 5678,
  tour_url: "http://www.realestateagent.com/tours?id=12345678"
})

# you can perform a check request (for validation or testing purposes)
client.check(payload)

# to actually send the tour data to Realtor.com, use the :submit method
client.submit(payload)
```

### API Version

By default, the `PicturepathAUI::Client` will use the PicturePath AUI API
version 5.1, however, you can change the API version to use when you
instantiate a client:

```ruby
client = PicturepathAUI::Client.new(
  username: "username", password: "password", api_version: "5.0"
)
```

Of course you will need to check the documentation as to the fields required
to populate your `PicturepathAUI::Request` object for the API version you choose.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/antillas21/picturepath_aui. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


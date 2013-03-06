# TestBisect

Don't you just hate this?

    $ rake test TEST=some_test.rb
    .
    1 test, 2 assertions, 0 failures, 0 errors
    100% passed

    $ rake test
    ....F..
    7 tests, 14 assertions, 1 failure, 0 errors
    93% passed

By using TestBisect you can search through your test suite to find out which leaky test is causing the failure.

## Installation

Add this line to your application's Gemfile:

    gem 'test_bisect'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_bisect

## Usage

Add this to your Rakefile or tests.rake:

    namespace :test do
      TestBisect::BisectTask.new
    end

And now, to find which leaky test file is causing, eg. some_test.rb to fail, you can do:

    rake test:bisect[test/some_test.rb]

It will do a binary search through your test files until it finds one (or more) that cause your test/some_test.rb to fail.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

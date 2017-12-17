## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'clarifai-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clarifai-rails

## Usage

### Initialize

    $ rails g clarifai:install

### Config API-KEY and Model code

Insert your application info in ```config/initializers/clarifai.rb```

### How to detect image

```ruby
  Clarifai::Rails::Detector.new(image_url).image
```

Custom model code
```ruby
  Clarifai::Rails::Detector.new(image_url, model_code).image
```

Return ```Clarifai::Rails::Image``` object

### For multiple images

```ruby
  Clarifai::Rails::Detector.new([image_url_1, image_url_2]).images
```

Custom model code
```ruby
  Clarifai::Rails::Detector.new([image_url_1, image_url_2], model_code).images
```

Return array ```Clarifai::Rails::Image``` object

### Note

With ```image``` is ```Clarifai::Rails::Image``` object

#### Get concepts

```ruby
  image.concepts
```
Return for you is a String array, it is concepts list

#### Get concepts with percent in image

```ruby
  image.concepts_with_percent
```
Return is a Hash with key is tag and value is percent

#### Get url

```ruby
  image.url
```
Return is a String

#### Get docid

```ruby
  image.docid
```
Return is a Number

Return is a String

#### Check status

```ruby
  image.success?
```
AND

```ruby
  image.error?
```

#### Get status_code

```ruby
  image.status_code
```
Return is a String

Can you see more info at https://developer.clarifai.com/docs/status_codes

#### Get status_msg

```ruby
  image.status_messages
```
Return is a String

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ThanhKhoaIT/clarifai-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


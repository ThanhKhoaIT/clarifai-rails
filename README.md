# Clarifai::Rails

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/clarifai/rails`. To experiment with that code, run `bin/console` for an interactive prompt.

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

### Config Client ID, Client Secret

Insert your application info in ```config/initializers/clarifai.rb```

### How to detect image

```ruby
  Clarifai::Rails::Detector.new(image_url).image
```

Return ```Clarifai::Rails::Image``` object

### For multiple images

```ruby
  Clarifai::Rails::Detector.new([image_url_1, image_url_2]).images
```

Return array ```Clarifai::Rails::Image``` object

### If you want to download images before detect (Facebook images, ...)

```ruby
  clarifai_detector = Clarifai::Rails::Detector.new([image_url_1, image_url_2])
  clarifai_detector.need_download!
  clarifai_detector.images
```

Return array ```Clarifai::Rails::Image``` object

### Note

With ```image``` is ```Clarifai::Rails::Image``` object

#### Get tags

```ruby
  image.tags
```
Return for you is a String array, it is tags list

#### Get tags with percent in image

```ruby
  image.tags_with_percent
```
Return is a Hash with key is tag and value is percent

#### Get url

```ruby
  image.url
```
Return ia a String

#### Get docid

```ruby
  image.docid
```
Return ia a Number

#### Get docid_str

```ruby
  image.docid_str
```
Return ia a String

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
Return ia a String

Can you see more info at https://developer.clarifai.com/docs/status_codes

#### Get status_msg

```ruby
  image.status_messages
```
Return ia a String

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ThanhKhoaIT/clarifai-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


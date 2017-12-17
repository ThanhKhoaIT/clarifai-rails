# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clarifai/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "clarifai-rails"
  spec.version       = Clarifai::Rails::VERSION
  spec.authors       = ["Khoa Nguyen"]
  spec.email         = ["thanhkhoait@gmail.com"]

  spec.summary       = %q{Clarifai API Rails Client}
  spec.description   = %q{Clarifai API Rails Client}
  spec.homepage      = "https://github.com/ThanhKhoaIT/clarifai-rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rest-client", "2.1.0.rc1"
end

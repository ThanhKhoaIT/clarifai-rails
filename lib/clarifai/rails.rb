require 'net/http'
require "clarifai/rails/version"

module Clarifai
  module Rails

    autoload :Token, "clarifai/rails/token"

    def self.setup
      yield self
    end

    mattr_accessor :client_id, :client_secret

    @@client_id = nil
    @@client_secret = nil

  end
end

require "clarifai/rails/token"

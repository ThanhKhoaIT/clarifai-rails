module Clarifai
  module Rails

    autoload :Token, "clarifai/rails/token"
    autoload :Detector, "clarifai/rails/detector"
    autoload :Image, "clarifai/rails/image"

    def self.setup
      yield self
    end

    mattr_accessor :client_id, :client_secret

    @@client_id = nil
    @@client_secret = nil

  end
end

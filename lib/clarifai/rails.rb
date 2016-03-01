module Clarifai
  module Rails

    autoload :Token, "clarifai/rails/token"
    autoload :Detector, "clarifai/rails/detector"
    autoload :Image, "clarifai/rails/image"
    autoload :Error, "clarifai/rails/error"

    def self.setup
      yield self
    end

    mattr_accessor :client_id, :client_secret, :tag_url

    @@client_id = nil
    @@client_secret = nil
    @@tag_url = "https://api.clarifai.com/v1/tag"

  end
end

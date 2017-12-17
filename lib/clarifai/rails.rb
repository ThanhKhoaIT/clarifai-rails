module Clarifai
  module Rails

    autoload :Detector, "clarifai/rails/detector"
    autoload :Image, "clarifai/rails/image"
    autoload :Error, "clarifai/rails/error"

    def self.setup
      yield self
    end

    mattr_accessor :api_key, :tag_url, :model_code

    @@api_key = nil
    @@tag_url = "https://api.clarifai.com/v2/models"
    @@model_code = nil

  end
end

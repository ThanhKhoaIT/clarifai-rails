require "open-uri"

module Clarifai
  module Rails
    class Detector

      def initialize(urls)
        raise "Input data not supported! (String Array or String only)" unless urls.is_a?(Array) || urls.is_a?(String)
        @@urls = urls.is_a?(Array) ? urls : [urls]

        @@clarifai_token_expire ||= Time.current
      end

      def image
        @data_urls ||= fetch
        Clarifai::Rails::Image.new(@data_urls["results"].first)
      end

      def images
        @data_urls ||= fetch
        @data_urls["results"].map do |json|
          Clarifai::Rails::Image.new(json)
        end
      end

      private

      def fetch
        new_token if @@clarifai_token_expire <= Time.current
        params_string = @@urls.join("&url=")
        response = open("https://api.clarifai.com/v1/tag?url=#{params_string}", "Authorization" => "Bearer #{@@clarifai_token["access_token"]}")

        JSON.parse(response.read)
      end

      def new_token
        @@clarifai_token = Clarifai::Rails::Token.new.create
        @@clarifai_token_expire = Time.current + @@clarifai_token["expires_in"]
      end

    end
  end
end

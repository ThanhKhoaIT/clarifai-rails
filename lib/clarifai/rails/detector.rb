require "open-uri"

module Clarifai
  module Rails
    class Detector

      def initialize(urls)
        raise "Input data not supported! (String Array or String only)" unless urls.is_a?(Array) || urls.is_a?(String)
        @@urls = urls.is_a?(Array) ? urls : [urls]

        @@clarifai_token_expire ||= Time.current
      end

      def to_hash
        @data_urls ||= fetch
        JSON.parse(@data_urls).symbolize_keys
      end

      def results
        to_hash[:results]
      end

      def images
        results.map do |json|
          Clarifai::Rails::Image.new(json)
        end
      end

      def image
        Clarifai::Rails::Image.new(results.first)
      end

      # Status method

      def error
        Clarifai::Rails::Error.detector(to_hash[:status_code])
      end

      def error?
        error.present?
      end

      def success?
        error.blank?
      end

      private

      def fetch
        new_token if @@clarifai_token_expire <= Time.current
        params_string = @@urls.join("&url=")
        response = open("https://api.clarifai.com/v1/tag?url=#{params_string}", "Authorization" => "Bearer #{@@clarifai_token[:access_token]}")
        response.read
      end

      def new_token
        @@clarifai_token = Clarifai::Rails::Token.new.create.symbolize_keys
        @@clarifai_token_expire = Time.current + @@clarifai_token[:expires_in]
      end

    end
  end
end

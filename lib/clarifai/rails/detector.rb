require "open-uri"
require "rest-client"

module Clarifai
  module Rails
    class Detector

      def initialize(urls, opts={})
        raise 'Input data not supported! (String Array or String only)' unless valid_params?(urls)
        @urls = urls.is_a?(Array) ? urls : [urls]
        @model_code = opts[:model] || Clarifai::Rails.model_code
        raise 'Model need to set' if @model_code.blank?
      end

      def to_hash
        @data_urls ||= fetch
        @data_urls.is_a?(Hash) ? @data_urls : JSON.parse(@data_urls).symbolize_keys
      end

      def results
        to_hash[:outputs]
      end

      def images
        results.map do |image|
          Clarifai::Rails::Image.new(image)
        end
      end

      def image
        Clarifai::Rails::Image.new(results.first)
      end

      # Status method

      def error
        Clarifai::Rails::Error.detector(to_hash[:status])
      end

      def error?
        error.present?
      end

      def success?
        error.blank?
      end

      private
      attr_reader :urls, :model_code

      def endpoint
        "#{Clarifai::Rails.tag_url}/#{model_code}/outputs"
      end

      def valid_params?(urls)
        urls.is_a?(Array) || urls.is_a?(String)
      end

      def fetch
        params = { inputs: urls.map{ |url| url_data(url) } }
        result = RestClient.post(endpoint, params.to_json, Authorization: "Key #{Clarifai::Rails.api_key}")
        JSON.parse(result).symbolize_keys
      end

      def url_data(url)
        { data: { image: { url: url } } }
      end

    end
  end
end

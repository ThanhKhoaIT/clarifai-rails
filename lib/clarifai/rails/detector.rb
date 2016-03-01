require "open-uri"
require "rest-client"

module Clarifai
  module Rails
    class Detector

      def initialize(urls, download=false)
        raise "Input data not supported! (String Array or String only)" unless urls.is_a?(Array) || urls.is_a?(String)

        @urls = urls.is_a?(Array) ? urls : [urls]
        @download = download
        $clarifai_token_expire ||= Time.current
      end

      def need_download!
        @download = true
        self
      end

      def to_hash
        @data_urls = fetch if @data_urls.blank?
        @data_urls.is_a?(Hash) ? @data_urls : JSON.parse(@data_urls).symbolize_keys
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
        new_token if $clarifai_token_expire <= Time.current
        @download ? urls_protected : urls_unprotected
      end

      def urls_unprotected
        params_string = @urls.join("&url=")
        response = open("#{Clarifai::Rails.tag_url}?url=#{params_string}", "Authorization" => "Bearer #{$clarifai_token[:access_token]}")
        response.read
      end

      def urls_protected
        data = { results: [], status_code: nil }
        @urls.each do |url|
          result = RestClient.post( Clarifai::Rails.tag_url,
                                   { encoded_data: File.new(open(url)) },
                                   Authorization: "Bearer #{$clarifai_token[:access_token]}")
          json = JSON.parse(result).symbolize_keys
          data[:results] << json[:results].first
          data[:status_code] = json[:status_code]
        end
        data
      end

      def new_token
        $clarifai_token = Clarifai::Rails::Token.new.create.symbolize_keys
        $clarifai_token_expire = Time.current + $clarifai_token[:expires_in]
      end

    end
  end
end

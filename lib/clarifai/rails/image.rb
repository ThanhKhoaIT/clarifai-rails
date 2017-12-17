module Clarifai
  module Rails
    class Image

      def initialize(json)
        @json = json.symbolize_keys
      end

      def docid
        json[:id]
      end

      def url
        json[:input]['data']['image']['url']
      rescue
        nil
      end

      def concepts
        raise error if error?
        data[:concepts].map{ |item| item['name'] }
      end

      def concepts_with_percent
        data[:concepts].map do |item|
          [item['name'], item['value']]
        end.to_h
      end

      def status_code
        status[:code]
      end

      def status_messages
        status[:description]
      end

      def error
        Clarifai::Rails::Error.detector(status_code)
      end

      def error?
        error.present?
      end

      def success?
        error.blank?
      end

      private

      attr_reader :json

      def data
        json[:data].symbolize_keys
      end

      def status
        json[:status].symbolize_keys
      end

    end
  end
end

module Clarifai
  module Rails
    class Image

      def initialize(json)
        @json = json.symbolize_keys
      end

      def docid
        json[:docid]
      end

      def url
        json[:url]
      end

      def tags
        raise error if error?
        result["tag"]["classes"]
      end

      def tags_with_percent
        tags_hash = {}
        tags.each_with_index do |tag, index|
          tags_hash["#{tag}"] = result["tag"]["probs"][index]
        end
        tags_hash.symbolize_keys
      end

      def status_code
        json[:status_code]
      end

      def status_messages
        json[:status_msg]
      end

      def docid_str
        result["docid_str"]
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

      def result
        json[:result]
      end

    end
  end
end

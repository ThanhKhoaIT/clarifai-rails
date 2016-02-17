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
        return nil if is_error?
        json[:result]["tag"]["classes"]
      end

      def tags_with_percent
        return nil if is_error?
        tags_hash = {}
        tags.each_with_index do |tag, index|
          tags_hash["#{tag}"] = json[:result]["tag"]["probs"][index]
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
        json[:result]["docid_str"]
      end

      def is_error?
        status_code != "OK"
      end

      def is_success?
        status_code == "OK"
      end

      protected

      attr_reader :json

    end
  end
end

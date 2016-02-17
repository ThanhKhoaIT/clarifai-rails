module Clarifai
  module Rails

    private

    class Token

      def initialize
        if Clarifai::Rails.client_id.blank? || Clarifai::Rails.client_secret.blank?
          raise "You need config client_id and client_secret for Application!"
        end
      end

      def create
        params = {
          grant_type: :client_credentials,
          client_id: Clarifai::Rails.client_id,
          client_secret: Clarifai::Rails.client_secret
        }
        token_uri = URI("https://api.clarifai.com/v1/token")

        https = Net::HTTP.new(token_uri.host, token_uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(token_uri.request_uri)
        request.set_form_data(params)
        body = https.request(request).body
        JSON.parse(body)
      end

    end
  end
end

require 'net/http'

module Clarifai
  class Rails
    class Token

      def self.get(client_id, client_secret)
        params = {
          grant_type: :client_credentials,
          client_id: client_id,
          client_secret: client_secret
        }
        token_uri = URI("https://api.clarifai.com/v1/token?#{params.to_query}")
        res = Net::HTTP.post_form(token_uri)
      end

    end
  end
end

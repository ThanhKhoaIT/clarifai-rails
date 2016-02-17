module Clarifai
  module Rails

    class Error < StandardError

      def initialize(code, text)
        @error_code = code
        @error_text = text
      end

      def code
        @error_code
      end

      def message
        @error_text
      end

      def self.detector(status_code)
        error = case status_code
                when "PARTIAL_ERROR"
                  PartialError.new(200, "Some images in request have failed. Please review the error messages per image.")
                when "ALL_ERROR"
                  AllError.new(400, "Bad request.")
                when "CLIENT_ERROR"
                  error_code = 400
                  error_text = "Data loading failed, see results for details."
                when "SERVER_ERROR"
                  error_code = 500
                  error_text = "Data failed to process, see results for details."
                when "TOKEN_APP_INVALID"
                  error_code = 401
                  error_text = "Application for this token is not valid. Please ensure that you are using ID and SECRET from same application."
                when "TOKEN_EXPIRED"
                  error_code = 401
                  error_text = "Token has expired, you must generate a new access token."
                when "TOKEN_INVALID"
                  error_code = 401
                  error_text = "Token is not valid. Please use valid tokens for a application in your account."
                when "TOKEN_NONE"
                  error_code = 401
                  error_text = "Authentication credentials were not provided in request."
                when "TOKEN_NO_SCOPE"
                  error_code = 401
                  error_text = "Token does not have the required scope to access resources."
                end

        return error if error.present?
      end

      class PartialError < Error; end
      class AllError < Error; end
      class ClientError < Error; end
      class ServerError < Error; end
      class TokenAppInvalid < Error; end

    end

  end
end

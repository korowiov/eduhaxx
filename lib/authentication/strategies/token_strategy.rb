require 'base64'

module Authentication
  module Strategies
    class TokenStrategy < ::Warden::Strategies::Base
      def valid?
        authentication_token.present?
      end

      def authenticate!
        account_id, token = decoded_token

        account =
          AccountRepository
          .new
          .find_by_token(token, account_id)

        account.nil? ? fail!('strategies.token.failed') : success!(account)
      end

      private

      def authentication_token
        @authentication_token ||=
          request.get_header('HTTP_X_ACCESS_TOKEN')
      end

      def decoded_token
        decrypted_token = Base64.decode64(authentication_token)
        decrypted_token.split(':')
      rescue StandardError
        nil
      end
    end
  end
end

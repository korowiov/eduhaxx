module Authentication
  module Strategies
    class CredentialsStrategy < ::Warden::Strategies::Base
      def valid?
        email.present? && password.present?
      end

      def authenticate!
        account =
          AccountRepository
          .new
          .find_by_credentials(email, password)

        account.nil? ? fail!('strategies.credentials.failed') : success!(account)
      end

      private

      def email
        @email ||=
          params['email'] || body['email']
      end

      def password
        @password ||=
          params['password'] || body['password']
      end

      def body
        @body ||=
          begin
            JSON.parse(request.env['rack.input'].gets)
          rescue StandardError
            {}
          end
      end
    end
  end
end

module Api
  module Authentication
    module HelperMethods
      def authenticate!
        request.env['warden'].authenticate!
      end

      def current_account
        request.env['warden'].user
      end

      def current_session
        @current_session ||=
          current_account.current_authentication_token
      end
    end
  end
end

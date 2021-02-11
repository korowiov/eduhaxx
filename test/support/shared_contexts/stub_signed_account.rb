module SharedContexts
  module StubSignedAccount
    extend ActiveSupport::Concern
    include SharedContexts::SetEncryptionKey

    included do
      let(:account_password) { 'AccountP4$$' }
      let(:account) do
        create(
          :account,
          password: account_password,
          password_confirmation: account_password
        )
      end
      let(:tokens) do
        Api::Authentication::TokenGenerator
          .prepare_tokens(account.id)
      end
      let(:session) do
        create(
          :authentication_token,
          account: account,
          token: tokens.first
        )
      end
      let(:authentication_headers) do
        {
          'X-Access-Token' => Base64.encode64("#{account.id}:#{tokens.last}")
        }
      end
    end

    def setup
      super()
      account
      session
    end
  end
end

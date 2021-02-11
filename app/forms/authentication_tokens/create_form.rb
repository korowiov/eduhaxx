require 'securerandom'

module AuthenticationTokens
  class CreateForm < ::BaseForm
    properties :account, :sign_in_ip, :token
    property :account_id, virtual: true
    property :hashed_token, virtual: true

    validates :account, presence: true
    validates :token, presence: true

    private

    def account_id=(value)
      super(value)

      account_resource =
        AccountRepository
        .new
        .find_by_id(value)

      self.account = account_resource

      if account_resource.present?
        self.token = generate_authentication_token.first
        self.hashed_token = generate_authentication_token.last
      end
    end

    def generate_authentication_token
      @generate_authentication_token ||=
        Api::Authentication::TokenGenerator
        .prepare_tokens(account_id)
    end
  end
end

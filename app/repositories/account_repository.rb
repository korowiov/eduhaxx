class AccountRepository
  def initialize(init_scope = nil)
    @scope = init_scope || Account
  end

  def find_by_credentials(email, password)
    return nil unless email.present? && password.present?

    account = @scope.find_by(email: email)
    account if account&.authenticate(password)
  end

  def find_by_token(encrypted_token, account_id)
    return nil if encrypted_token.blank? || account_id.blank?

    authentication_token =
      Api::Authentication::TokenGenerator
      .decrypt(account_id, encrypted_token)

    token_record =
      AuthenticationTokenRepository
      .new
      .find_by_token(authentication_token)

    account = token_record&.account
    account.current_token = token_record if account

    account
  end

  def find_by_id(account_id)
    return nil unless account_id.present?

    @scope.find_by(id: account_id)
  end
end

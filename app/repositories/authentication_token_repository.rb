class AuthenticationTokenRepository
  def initialize(init_scope = nil)
    @scope = init_scope || AuthenticationToken
  end

  def find_by_token(token_value)
    return nil if token_value.blank?

    @scope.includes(:account)
          .not_expired
          .find_by(token: token_value)
  end
end

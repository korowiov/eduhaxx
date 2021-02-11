class SessionsSerializer < Patterns::Serializer
  attribute :token
  attribute :account_id
  attribute :email
  attribute :nickname

  def token
    object.hashed_token
  end

  def account_id
    object.account.id
  end

  def email
    object.account.email
  end

  def nickname
    object.account.nickname
  end
end

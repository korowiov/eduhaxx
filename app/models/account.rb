class Account < ApplicationRecord
  attr_accessor :current_token

  has_secure_password
  has_secure_password :recovery_password, validations: false

  has_many :authentication_tokens
  has_many :quiz_sessions
end

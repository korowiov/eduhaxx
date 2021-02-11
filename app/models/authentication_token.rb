class AuthenticationToken < ApplicationRecord
  attr_accessor :hashed_token

  belongs_to :account

  scope :not_expired, -> { where(expired: false) }

  def expire!
    update(expired: true) unless expired
  end
end

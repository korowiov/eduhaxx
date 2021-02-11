module Accounts
  class CreateForm < ::BaseForm
    properties :email, :nickname, :password, :password_confirmation

    validates :email, presence: true,
                      format: URI::MailTo::EMAIL_REGEXP
    validates_uniqueness_of :email
    validates :password, presence: true,
                         format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}\z/ }
    validates :nickname, presence: true
    validate :confirmation_of_password

    private

    def confirmation_of_password
      errors.add(:password_confirmation, :invalid) if password != password_confirmation
    end
  end
end

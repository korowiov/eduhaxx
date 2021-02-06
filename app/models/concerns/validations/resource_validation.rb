module Validations
  module ResourceValidation
    extend ActiveSupport::Concern

    included do
      validates :name, presence: true
      validates :description, presence: true
      validates :education_level, presence: true

      validates_length_of :subjects,
                          minimum: 1,
                          message: 'requires minimum %{count} subject'
    end
  end
end
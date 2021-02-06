module Validations
  module TagValidation
    extend ActiveSupport::Concern

    included do
      validates :label, presence: true
    end
  end
end

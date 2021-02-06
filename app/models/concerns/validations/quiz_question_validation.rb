module Validations
  module QuizQuestionValidation
    extend ActiveSupport::Concern

    included do
      validates :content, presence: true
      validates :question_type, presence: true
      validate :valid_question_options

      private

      def extend_validation
        extend validation_class.constantize
      end

      def valid_question_options
        extend_validation

        errors.add(:question_options, :invalid) unless validation_condition_fulfilled?
      end

      def validation_condition_fulfilled?
        validation_conditions.inject(true) do |value, condition|
          return value unless value

          condition.call
        end
      end

      def validation_class
        [
          'Validations',
          'QuizQuestionValidation',
          question_type.classify
        ].join('::')
      end
    end
  end
end

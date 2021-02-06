module Validations
  module QuizQuestionValidation
    module MultiplePickType
      include BaseValidation

      private

      def validation_conditions
        [
          -> { options_count.eql?(4) },
          -> { question_options.all? { |opt| opt.content.present? } },
          -> { question_options.all? { |opt| opt.value.in? true_false_value } },
          -> { true_values_count > 1 }
        ]
      end

      def true_values_count
        question_options.inject(0) do |value, opt|
          value += 1 if opt.value == true
          value
        end
      end
    end
  end
end

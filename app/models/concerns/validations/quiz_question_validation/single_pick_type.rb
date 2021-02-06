module Validations
  module QuizQuestionValidation
    module SinglePickType
      include BaseValidation

      private

      def validation_conditions
        [
          -> { options_count.eql?(4) },
          -> { question_options.all? { |opt| opt.content.present? } },
          -> { question_options.all? { |opt| opt.value.in? true_false_value } },
          -> { question_options.one? { |opt| opt.value == true } }
        ]
      end
    end
  end
end

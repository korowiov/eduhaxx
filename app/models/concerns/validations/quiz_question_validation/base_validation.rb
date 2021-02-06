module Validations
  module QuizQuestionValidation
    module BaseValidation
      extend ActiveSupport::Concern

      included do
        protected

        def options_count
          question_options.records.count
        end

        def true_false_value
          [true, false]
        end
      end
    end
  end
end

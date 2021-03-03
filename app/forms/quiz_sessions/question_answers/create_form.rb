module QuizSessions
  module QuestionAnswers
    class CreateForm < ::BaseForm
      property :quiz_question, virtual: true
      validate :valid_quiz_answers

      collection :quiz_answers, populate_if_empty: QuizAnswer do
        properties :quiz_session, :quiz_question, :question_option_id

        validates :quiz_session, presence: true
        validates :quiz_question, presence: true
        validates :question_option_id, presence: true

        validate :valid_question_option

        def valid_question_option
          errors.add(:question_option_id, :invalid) unless option_exists_in_quiz?
        end

        def option_exists_in_quiz?
          quiz_question
            .question_options
            .exists?(question_option_id)
        end
      end

      private

      def valid_quiz_answers
        errors.add(:quiz_answers, :invalid) unless quiz_answers_valid?
      end

      def quiz_answers_valid?
        quiz_answers_count_valid? && quiz_answers_unique_valid?
      end

      def quiz_answers_count_valid?
        case quiz_question.question_type
        when 'single_pick_type'
          quiz_answers.count.eql?(1)
        when 'multiple_pick_type'
          quiz_answers.count.between?(1, 4)
        else
          false
        end
      end

      def quiz_answers_unique_valid?
        quiz_answers
          .map(&:question_option_id)
          .uniq
          .count
          .eql?(quiz_answers.count)
      end
    end
  end
end

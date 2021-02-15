module QuizSessions
  module Configuration
    class Build
      include Patterns::Services

      def initialize(quiz:)
        @quiz = quiz
      end

      def call
        QuizSessionConfiguration
          .new(params_configuration)
      end

      private

      attr_reader :quiz

      def params_configuration
        {}.tap do |param|
          param[:total_score] = total_score
          param[:questions_order] = questions_order
        end
      end

      def total_score
        quiz_questions.inject(0) do |sum, question|
          case question.question_type
          when 'single_pick_type'
            sum += 1
          else
            value = question.question_options.count do |opt|
              opt.value.eql?('true')
            end
            sum += value
          end

          sum
        end
      end

      def questions_order
        quiz_questions
          .random_order
          .map(&:id)
      end

      def quiz_questions
        @quiz_questions ||=
          quiz
          .quiz_questions
          .includes(:question_options)
      end
    end
  end
end

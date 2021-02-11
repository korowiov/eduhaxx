module QuizSessions
  module Configuration
    class Build
      include Patterns::Services

      def initialize(quiz:)
        @quiz = quiz
      end

      def call
        QuizSessionConfiguration.new(params_configuration)
      end

      private

      attr_reader :quiz

      def params_configuration
        {}.tap do |param|
          param[:total_score] = total_score
          param[:questions_order] = questions_order
          param[:question_options_order] = question_options_order
        end
      end

      def total_score
        quiz_questions.inject(0) do |sum, question|
          case question.question_type
          when 'single_pick_type'
            sum += 1
          when 'multiple_pick_type'
            value = question.quiz_question_options.count do |opt| 
              opt.value.eql?('true')
            end
            sum += value
          else
            value = question.quiz_question_options.size
            sum += value
          end

          sum
        end
      end

      def question_options_order
        quiz_questions.each_with_object({}) do |question, hsh|
          next hsh unless question.mutable?
  
          hsh[question.id] = question
                             .options
                             .random_order
                             .pluck(:id)
          hsh
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
          .includes(:quiz_question_options)
      end
    end
  end
end
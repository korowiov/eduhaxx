module QuizSessions
  module QuestionAnswers
    class Create < Patterns::Action
      set_form_klass QuizSessions::QuestionAnswers::CreateForm

      def initialize(quiz_session:, quiz_question:, answers:)
        @quiz_session = quiz_session
        @quiz_question = quiz_question
        @answers = answers
      end

      def call
        form.validate(params)
      end

      private

      attr_reader :answers, :quiz_question, :quiz_session

      def params
        {
          quiz_question: quiz_question,
          quiz_answers: quiz_answers
        }
      end

      def quiz_answers
        answers.map do |answer|
          {
            question_option_id: answer,
            quiz_session: quiz_session,
            quiz_question: quiz_question
          }
        end
      end

      def form
        @form ||=
          form_klass.new(quiz_session)
      end
    end
  end
end

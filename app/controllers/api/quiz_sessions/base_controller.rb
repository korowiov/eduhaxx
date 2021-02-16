module Api
  module QuizSessions
    class BaseController < AuthenticatedController
      protected

      def quiz_session
        @quiz_session ||=
          QuizSessionRepository.new
                               .find_active!(
                                 params[:id]
                               )
      end

      def quiz_question
        @quiz_question ||=
          QuizQuestions::FindQuery.call(
            quiz_session: quiz_session,
            question_number: params[:question_number]
          )
      end
    end
  end
end

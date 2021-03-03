require_relative 'base_controller'

module Api
  module QuizSessions
    class QuestionAnswersController < BaseController
      def create
        action =
          ::QuizSessions::QuestionAnswers::Create
          .new(
            quiz_session: quiz_session,
            quiz_question: quiz_question,
            answers: create_params[:answers]
          )

        if action.call
          head :created
        else
          render_errors(action)
        end
      end

      private

      def create_params
        params.permit(answers: [])
      end
    end
  end
end

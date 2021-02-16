require_relative 'base_controller'

module Api
  module QuizSessions
    class QuizQuestionsController < BaseController
      def show
        render_object(
          quiz_question,
          QuizQuestionSerializer
        )
      end
    end
  end
end

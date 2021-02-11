module Api
  class QuizSessionsController < AuthenticatedController
    def create
      @quiz_session = QuizSessions::Create.new(
        account: current_account,
        quiz: quiz
      ).call

      render_object(
        @quiz_session,
        QuizSessionSerializer,
        only: :id
      )
    end

    private

    def quiz
      Quiz.published
          .find(params[:quiz_id])
    end
  end
end

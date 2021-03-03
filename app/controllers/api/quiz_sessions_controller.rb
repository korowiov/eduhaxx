module Api
  class QuizSessionsController < AuthenticatedController
    def create
      action =
        ::QuizSessions::Create.new(
          account: current_account,
          quiz: quiz
        )

      if action.call
        render_object(
          action.resource,
          QuizSessionSerializer,
          only: :id
        )
      end
    end

    def show
      authorize quiz_session

      render_object(
        quiz_session,
        QuizSessionSerializer
      )
    end

    def edit
      authorize quiz_session

      action =
        ::QuizSessions::Edit.new(
          quiz_session: quiz_session
        )

      action.call
      head :ok
    end

    private

    def quiz
      ResourceRepository.new(Quiz)
                        .published_by_id!(
                          params[:quiz_id]
                        )
    end

    def quiz_session
      QuizSessionRepository.new
                           .find_active!(
                             params[:id]
                           )
    end
  end
end

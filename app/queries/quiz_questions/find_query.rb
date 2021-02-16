module QuizQuestions
  class FindQuery
    include Patterns::Services

    def initialize(quiz_session:, question_number:)
      @quiz_session = quiz_session
      @question_number = question_number.to_i
    end

    def call
      QuizQuestionRepository
        .new
        .find_by_id!(question_id)
    end

    private

    attr_reader :question_number, :quiz_session

    def question_index
      return nil unless question_number&.between?(1, quiz_question_count)

      (question_number - 1)
    end

    def quiz_question_count
      quiz_session.quiz_questions.count
    end

    def question_id
      index = question_index
      return unless index.present?

      quiz_session
        .configuration
        .questions_order[index]
    end
  end
end

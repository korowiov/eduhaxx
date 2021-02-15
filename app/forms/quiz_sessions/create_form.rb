module QuizSessions
  class CreateForm < ::BaseForm
    properties :account, :quiz, :configuration

    validates :account, presence: true
    validates :quiz, presence: true
    validates :configuration, presence: true
    validate :published_quiz

    private

    def quiz=(quiz_instance)
      super(quiz_instance)
      self.configuration = session_configuration(quiz_instance)
    end

    def published_quiz
      errors.add(:quiz, :invalid) unless quiz.published?
    end

    def session_configuration(quiz_instance)
      QuizSessions::Configuration::Build
        .call(quiz: quiz_instance)
    end
  end
end

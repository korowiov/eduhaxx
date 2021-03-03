module QuizSessions
  class Edit < Patterns::Action
    set_form_klass QuizSessions::EditForm

    def initialize(quiz_session:)
      @quiz_session = quiz_session
    end

    private

    attr_reader :quiz_session

    def params
      {
        finished_at: Time.now
      }
    end

    def form
      @form ||=
        form_klass.new(quiz_session)
    end
  end
end

module QuizSessions
  class Create < Patterns::Action
    set_form_klass QuizSessions::CreateForm
    set_model_klass QuizSession

    def initialize(account:, quiz:, opts: {})
      @account = account
      @quiz = quiz
      @opts = opts
    end

    def call
      !!existing_resource || super
    end

    def resource
      existing_resource || form.model
    end

    private

    attr_reader :account, :quiz, :opts

    def params
      {}.tap do |param|
        param[:account] = account
        param[:quiz] = quiz
      end
    end

    def existing_resource
      @existing_resource ||=
        QuizSessionRepository
        .new
        .find_by_attrs(
          account: account,
          quiz: quiz
        )
    end
  end
end

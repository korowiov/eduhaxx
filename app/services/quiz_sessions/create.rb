module QuizSessions
  class Create
    include Patterns::Services

    def initialize(account:, quiz:, opts: {})
      @account = account
      @quiz = quiz
      @opts = opts
    end

    def call
      quiz_session.tap(&:save!)
    end

    private

    attr_reader :account, :quiz, :opts

    def params
      {}.tap do |param|
        param[:account] = account
        param[:quiz] = quiz
        param[:configuration] = quiz_session_configuration
      end
    end

    def quiz_session
      @quiz_session ||=
        QuizSession.new(params)
    end

    def quiz_session_configuration
      QuizSessions::Configuration::Build.call(quiz: quiz)
    end
  end
end

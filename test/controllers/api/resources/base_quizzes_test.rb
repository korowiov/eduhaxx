require_relative 'base_test'

module ApiTests
  module ResourcesControllerTests
    class BaseQuizzesTest < BaseTest
      let(:quizzes) do
        build_list(
          :quiz,
          10,
          :published,
          quiz_questions: build_list(:quiz_question, 6) | build_list(:quiz_question, 6, :multiple_pick_type)
        )
      end

      before do
        quizzes
      end
    end
  end
end

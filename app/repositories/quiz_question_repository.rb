class QuizQuestionRepository < BaseRepository
  set_repository_klass QuizQuestion

  def find_by_id!(id)
    scope.includes(:question_options)
         .find_by!(id: id)
  end
end

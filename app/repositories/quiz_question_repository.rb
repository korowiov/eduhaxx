class QuizQuestionRepository < BaseRepository
  set_repository_klass QuizQuestion

  def find_by_id!(id)
    scope.find_by!(id: id)
  end
end

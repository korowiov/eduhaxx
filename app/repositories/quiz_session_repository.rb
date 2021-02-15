class QuizSessionRepository < BaseRepository
  set_repository_klass QuizSession

  def find_active!(id)
    scope.where(finished_at: nil)
         .find_by!(id: id)
  end

  def find_by_attrs(**attrs)
    scope.where(finished_at: nil)
         .find_by(attrs)
  end
end

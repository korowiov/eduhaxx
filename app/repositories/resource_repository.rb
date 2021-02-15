class ResourceRepository < BaseRepository
  set_repository_klass Subject

  def find_by_id!(id)
    scope.find_by!(id: id)
  end

  def published_by_id!(id)
    @scope = scope.published
    find_by_id!(id)
  end
end

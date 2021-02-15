class BaseRepository
  class MissingAttribute < StandardError; end

  delegate :repository_klass, to: :"self.class"

  class << self
    def set_repository_klass(repository_klass)
      @repository_klass = repository_klass
    end

    def repository_klass
      raise MissingAttribute if @repository_klass.nil?

      @repository_klass
    end
  end

  def initialize(init_scope = nil)
    @scope = init_scope || repository_klass
  end

  protected

  attr_reader :scope
end

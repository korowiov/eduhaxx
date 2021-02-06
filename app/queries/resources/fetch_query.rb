module Resources
  class FetchQuery
    include Patterns::Services

    LIMIT_PER_PAGE = 10

    def initialize(init_scope: nil, params:)
      @init_scope = init_scope
      @params = params
    end

    def call
      scoped = initial_scope.includes(:subjects, :education_level)
      scoped = filter_by_education_level(scoped)
      scoped = filter_by_subject(scoped)
      scoped = limit_offset(scoped)
      scoped = sort_by(scoped)
      scoped
    end

    private

    attr_reader :init_scope, :params

    def initial_scope
      return init_scope if init_scope.present?
      return Resource.published if params.phrase.nil?

      Resource.where(id: searchable_ids)
    end

    def filter_by_subject(scope)
      return scope unless params.subjects?

      subjects = Subject.where(slug: params.subjects)
      scope
        .joins(:resource_subjects)
        .where(resource_subjects: { subject_id: subjects.pluck(:id) })
    end

    def filter_by_education_level(scope)
      return scope unless params.education_level?

      scope
        .where(education_level_id: params.education_level)
    end

    def limit_offset(scope)
      page = (params.page || 1) - 1

      scope
        .limit(LIMIT_PER_PAGE)
        .offset(LIMIT_PER_PAGE * page)
    end

    def searchable_ids
      PgSearch
        .multisearch(params.phrase)
        .map(&:searchable_id)
    end

    def sort_by(scope)
      case params.sort
      when 'date_asc' then scope.order(published_at: :asc)
      when 'date_desc' then scope.order(published_at: :desc)
      else
        scope.order(published_at: :desc)
      end
    end
  end
end

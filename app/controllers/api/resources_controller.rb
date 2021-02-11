module Api
  class ResourcesController < BaseApiController
    def index
      @resources =
        Resources::Fetch::Action
        .new(**resource_params)
        .call

      render_collection(
        @resources,
        ResourceSerializer
      )
    end

    def show
      render_object(
        resource_record,
        resource_serializer
      )
    end

    private

    def resource_params
      params.permit(
        :page,
        :phrase,
        :sort,
        education_level: [],
        subjects: []
      )
    end

    def resource_record
      @resource_record ||=
        Resource.published.find(params[:id])
    end

    def resource_serializer
      case resource_record
      when Quiz then ResourceSerializer
      end
    end
  end
end

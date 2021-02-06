module Api
  class BaseApiController < ActionController::API
    include ExceptionsHandler

    protected

    def render_errors(resource, http_code = 422)
      render json: resource.errors.messages, status: http_code
    end

    def render_collection(resource, serializer)
      render json: resource,
             each_serializer: serializer,
             serializer: ActiveModel::Serializer::CollectionSerializer,
             status: 200
    end

    def render_object(resource, serializer, opt = {})
      render json: serializer.new(resource, opt).serializable_hash,
             status: 200
    end
  end
end

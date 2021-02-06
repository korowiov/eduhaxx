class CollectionSerializer
  def initialize(objects, serializer, **kwargs)
    @objects    = objects
    @serializer = serializer
    @context    = kwargs
  end

  def call
    [].tap do |elements|
      objects.each do |object|
        elements << serializer.new(object, context).serializable_hash
      end
    end
  end

  private

  attr_reader :objects, :serializer, :context
end
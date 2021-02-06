module Resources
  module Fetch
    class Action
      include Patterns::Services

      def initialize(**params)
        @params = Params.new(params)
        raise_exception! unless @params.valid?
      end

      def call
        Resources::FetchQuery
          .new(params: params)
          .call
      end

      private

      attr_reader :params

      def raise_exception!
        raise ExceptionsHandler::InvalidParams, 'Invalid fetch resource params'
      end
    end
  end
end
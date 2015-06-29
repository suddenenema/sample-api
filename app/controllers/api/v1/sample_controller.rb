module Api
  module V1
    class SampleController < ApplicationApiController

      def index
        if Client.authorized?(request.query_parameters)
          render json: { data: 'private data' }
        else
          render json: { data: 'anauthorized' }
        end
      end

    end
  end
end

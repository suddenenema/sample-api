module Api
  module V1
    class SampleController < ApplicationApiController

      def index
        client = Client.authorize(request.query_parameters)

        if client
          render json: { data: 'authorized data' }
        else
          render json: { data: 'anauthorized' }, status: 401
        end
      end

    end
  end
end

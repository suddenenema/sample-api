module Api
  module V1
    class SampleController < ApplicationApiController

      def index
        render json: { data: 'private data' }
      end

    end
  end
end

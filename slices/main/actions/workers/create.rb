# frozen_string_literal: true
module Main
  module Actions
    module Workers
      class Create < Action
      include Deps['repositories.workers']
        def handle(request, response)
          response.format = :json
          response.body = Serializers::Worker.new(workers.create(request.params)).serialize
        end
      end
    end
  end
end

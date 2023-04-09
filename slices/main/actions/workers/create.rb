# frozen_string_literal: true
module Main
  module Actions
    module Workers
      class Create < Wps::Action
      include Deps['repositories.workers']
        params do
          required(:worker).hash do
            required(:name).filled(:str?)
          end
        end

        def handle(request, response)
          response.format = :json
          worker = workers.create(request.params[:worker])
          response.body = Serializers::Worker.new(worker).serialize
        end
      end
    end
  end
end
